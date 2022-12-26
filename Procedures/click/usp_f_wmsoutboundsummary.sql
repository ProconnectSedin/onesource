-- PROCEDURE: click.usp_f_wmsoutboundsummary()

-- DROP PROCEDURE IF EXISTS click.usp_f_wmsoutboundsummary();

CREATE OR REPLACE PROCEDURE click.usp_f_wmsoutboundsummary(
	)
LANGUAGE 'plpgsql'
AS $BODY$
	DECLARE 
		p_errorid integer;
		p_errordesc character varying;
BEGIN

DELETE FROM click.f_outboundpickpackdetail pick
USING click.f_outboundorderdetail ord
WHERE pick.pickpack_ordkey = ord.ord_key
AND ord.ord_orderdate >= (NOW() - INTERVAL '90 days')::DATE;

DELETE FROM click.f_outboundorderdetail 
WHERE ord_orderdate >= (NOW() - INTERVAL '90 days')::DATE;

INSERT INTO click.f_outboundorderdetail
(
	ord_lockey,
	ord_custkey,
	ord_datekey,
	ord_custcode,
	ord_ou,
	ord_loccode,
	ord_refdoctype,
	ord_ordertype ,
	ord_obstatus ,
	ord_orderdate,
	ord_shipmentmode ,
	ord_shipmenttype ,
	ord_subservicetype,
	ord_state ,
    ord_city ,
    ord_postcode,
	ord_sono,
	ord_itmlineno,
	ord_ordqty,
	ord_balqty,
	ord_issueqty,
	ord_processqty,
	ord_itmvolume,
	ord_itmwgt,
	ord_wavestatus,
	ord_waveallocrule,
	ord_waveqty
)
SELECT 	obh_loc_key,	
		obh_cust_key,	
		oub_orderdatekey,
		oub_cust_code,
		oub_ou,	
		obh.oub_loc_code,	
		obh.oub_prim_rf_dc_typ,	
		obh.oub_order_type,	
		obh.oub_ob_status,	
		COALESCE(obh.oub_modified_date,obh.oub_created_date)::DATE,	
		obh.oub_shipment_mode,	
		obh.oub_shipment_type,
		obh.oub_subservice_type,	
		obh.oub_state,	
		obh.oub_city,	
		obh.oub_postcode,
		oub_prim_rf_dc_no,
		COUNT(oub_itm_lineno),
		SUM(COALESCE(oub_itm_order_qty,0)),
		SUM(COALESCE(oub_itm_balqty,0)),
		SUM(COALESCE(oub_itm_issueqty,0)),
		SUM(COALESCE(oub_itm_processqty,0)),
		SUM(obd.oub_itm_volume),
		SUM(obd.oub_itm_weight),
		wh.wave_status,
		wh.wave_alloc_rule,
		SUM(wave_qty)
FROM  dwh.F_OutboundHeader obh
INNER JOIN dwh.F_OutboundItemDetail obd
ON	obh.obh_hr_key = obd.obh_hr_key
LEFT JOIN dwh.f_wavedetail wd
ON  wd.wave_ou 		 = obh.oub_ou
AND wd.wave_loc_key  = obh.obh_loc_key
AND wd.wave_cust_key = obh.obh_cust_key
AND wd.wave_item_key = obd.obd_itm_key
AND wd.wave_so_no 	 = obh.oub_prim_rf_dc_no
LEFT JOIN dwh.f_waveheader wh
ON  wd.wave_hdr_key = wh.wave_hdr_key
WHERE obh.oub_ob_status <> 'CN'
AND COALESCE(obh.oub_modified_date,obh.oub_created_date)::date >= (NOW() - INTERVAL '90 days')::DATE
GROUP BY 
		obh_loc_key,	
		oub_orderdatekey,
		obh_cust_key,	
		oub_cust_code,
		oub_ou,	
		obh.oub_loc_code,	
		obh.oub_prim_rf_dc_typ,	
		obh.oub_order_type,	
		obh.oub_ob_status,	
		COALESCE(obh.oub_modified_date,obh.oub_created_date)::DATE,	
		obh.oub_shipment_mode,	
		obh.oub_shipment_type,
		obh.oub_subservice_type,	
		obh.oub_state,	
		obh.oub_city,	
		obh.oub_postcode,
		oub_prim_rf_dc_no,
		wh.wave_status,
		wh.wave_alloc_rule;
		
--TRUNCATE TABLE click.f_outboundpickpackdetail;
INSERT INTO click.f_outboundpickpackdetail(
	pickpack_ou,
	pickpack_lockey,
	pickpack_ordkey,
	pickpack_sono,
	pickexecstatus,
	picklineno,
	pickqty,
	pickemployee ,
	pickmechine ,
	pickhttflag ,
	pickthuwgt	
)
SELECT 
		sum1.ord_ou,
		sum1.ord_lockey,
		sum1.ord_key,
		sum1.ord_sono,
		PickH.pick_exec_status,
		COUNT(distinct PickD.pick_lineno),
		SUM(PickD.pick_qty),
		COUNT(distinct PickH.pick_employee),
		COUNT(distinct PickH.pick_mhe),
		CASE WHEN PickH.pick_gen_from = 'WMS_MOB' THEN 1 ELSE 0 END HTTFlag,
		SUM(PickD.pick_exec_thu_wt)
FROM click.f_outboundorderdetail sum1
INNER JOIN dwh.f_pickingdetail PickD
ON  sum1.ord_ou =  PickD.pick_exec_ou
AND sum1.ord_lockey = PickD.pick_loc_key
AND sum1.ord_sono = PickD.pick_so_no
INNER JOIN dwh.f_pickingheader PickH
ON PickH.pick_hdr_key = PickD.pick_hdr_key
WHERE sum1.ord_orderdate >= (NOW() - INTERVAL '90 days')::DATE
--WHERE pickD.pick_so_no = 'W310000070'
GROUP BY 
sum1.ord_ou,
sum1.ord_lockey,
sum1.ord_key,
sum1.ord_sono,
PickH.pick_exec_status,
PickH.pick_gen_from;

UPDATE click.f_outboundpickpackdetail t1
SET packexecstatus  = p1.packexecstatus,
	packlineno	 = p1.totlineno,
	packqty		 = p1.totpackqty,
	packtolqty 	 = p1.tottolqty,
	packemployee = p1.totemp
FROM 
	(	SELECT 
			sum1.ord_ou,
			sum1.ord_lockey,
			sum1.ord_key,
			sum1.ord_sono,
			PackH.pack_exec_status as packexecstatus,
			COUNT(distinct PackD.pack_thu_lineno) as totlineno,
			SUM(PackD.pack_thu_pack_qty) as totpackqty,
			SUM(PackD.pack_tolerance_qty) as tottolqty,
			COUNT(distinct PackH.pack_employee)	 as totemp
		FROM click.f_outboundorderdetail sum1
		LEFT JOIN dwh.F_PackExecTHUDetail PackD
		ON  sum1.ord_ou = PackD.pack_exec_ou
		AND sum1.ord_lockey  = PackD.pack_exec_loc_key
		AND sum1.ord_sono = PackD.pack_so_no
		LEFT JOIN dwh.F_PackExecHeader PackH
		ON PackH.pack_exe_hdr_key = PackD.pack_exec_hdr_key
	 	WHERE sum1.ord_orderdate >= (NOW() - INTERVAL '90 days')::DATE
		GROUP BY 
		sum1.ord_ou,
		sum1.ord_lockey,
		sum1.ord_key,
		sum1.ord_sono,
		PackH.pack_exec_status
	) P1
WHERE 	t1.pickpack_ordkey		=	p1.ord_key;

--TRUNCATE TABLE click.f_wmsoutboundsummary;
 DELETE FROM click.f_wmsoutboundsummary
 WHERE oub_orderdate >= (NOW() - INTERVAL '90 days')::DATE;

INSERT INTO click.f_wmsoutboundsummary(
		oub_ou ,
		oub_customerkey ,
		oub_datekey ,
		oub_locationkey ,
		oub_loccode ,
		oub_custcode ,
		oub_primrfdctyp ,
		oub_ordertype ,
		oub_obstatus ,
		oub_shipmentmode ,
		oub_orderdate,
		oub_shipmenttype,
		oub_subservicetype ,
		oub_state ,
		oub_city ,
		oub_postcode,
		oub_totoutboundord,
		oub_totoutboundline ,
		oub_totordqty,
		oub_totbalqty ,
		oub_totisuqty ,
		oub_totprosqty ,
		oub_totoutboundvol ,
		oub_totoutboundwgt,
		oub_wavestatus,
		oub_waveallocrule,
		oub_pickexecstatus,
		oub_packexecstatus,
		oub_waveqty,
		oub_totpickline,
		oub_totpickqty ,
		oub_totpickemp ,
		oub_totpickmechines ,
		oub_totpickhht ,
		oub_totpickthuwgt,
		oub_totpackline,
		oub_totpackqty ,
		oub_totpacktolqty ,
		oub_totpackemp
)

SELECT 	a.ord_ou,
		a.ord_custkey,
		a.ord_datekey,
		a.ord_lockey,
		a.ord_loccode,
		a.ord_custcode,
		a.ord_refdoctype,
		a.ord_ordertype ,
		a.ord_obstatus ,
		a.ord_shipmentmode ,
		a.ord_orderdate,
		a.ord_shipmenttype ,
		a.ord_subservicetype ,
		a.ord_state ,
		a.ord_city ,
		a.ord_postcode,
		COUNT(distinct ord_sono),
		MAX(ord_itmLineno),
		MAX(ord_ordqty),
		MAX(ord_balqty),
		MAX(ord_issueqty),
		MAX(ord_processqty),
		MAX(ord_itmvolume),
		MAX(ord_itmwgt),
		a.ord_wavestatus,
		a.ord_waveallocrule,
		b.pickexecstatus,
		b.packexecstatus,
		MAX(ord_waveqty),
		MAX(b.picklineno),
		MAX(b.pickqty),
		MAX(b.pickemployee),
		MAX(b.pickmechine),
		MAX(b.pickhttflag),
		MAX(b.pickthuwgt),
		MAX(b.packlineno),
		MAX(b.packqty),
		MAX(b.packtolqty),
		MAX(b.packemployee)
FROM click.f_outboundorderdetail a
LEFT JOIN click.f_outboundpickpackdetail b
ON  a.ord_key		= 	b.pickpack_ordkey
GROUP BY 	a.ord_ou,
			a.ord_custkey,
			a.ord_datekey,
			a.ord_lockey,
			a.ord_loccode,
			a.ord_custcode,
			a.ord_refdoctype,
			a.ord_ordertype ,
			a.ord_obstatus ,
			a.ord_shipmentmode ,
			a.ord_orderdate,
			a.ord_shipmenttype ,
			a.ord_subservicetype ,
			a.ord_state ,
			a.ord_city ,
			a.ord_postcode,
			a.ord_wavestatus,
			a.ord_waveallocrule,
			b.pickexecstatus,
			b.packexecstatus;
			--,c.sla_category;
			
	EXCEPTION WHEN others THEN       

		GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

		CALL ods.usp_etlerrorinsert('CLICK','f_wmsoutboundsummary','Click',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);			
		
END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmsoutboundsummary()
    OWNER TO proconnect;
