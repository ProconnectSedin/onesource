-- PROCEDURE: click.usp_f_wmsoutboundorddetail()

-- DROP PROCEDURE IF EXISTS click.usp_f_wmsoutboundorddetail();

CREATE OR REPLACE PROCEDURE click.usp_f_wmsoutboundorddetail(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    p_errorid integer;
	p_errordesc character varying;
BEGIN

DELETE FROM click.f_outboundsladetail sla
USING click.f_outboundorderdetail ord
WHERE sla.sla_ordkey = ord.ord_key
AND ord.ord_orderdate >= (NOW() - INTERVAL '3 MONTHS')::DATE;

DELETE FROM click.f_outboundpickpackdetail pick
USING click.f_outboundorderdetail ord
WHERE pick.pickpack_ordkey = ord.ord_key
AND ord.ord_orderdate >= (NOW() - INTERVAL '3 MONTHS')::DATE;

DELETE FROM click.f_outboundorderdetail 
WHERE ord_orderdate >= (NOW() - INTERVAL '3 MONTHS')::DATE;

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
	ord_refdocno,
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
AND obh.oub_orderdate::DATE  >= (NOW() - INTERVAL '3 MONTHS')::DATE
LEFT JOIN dwh.f_wavedetail wd
ON  wd.wave_ou 		 = obh.oub_ou
AND wd.wave_loc_key  = obh.obh_loc_key
AND wd.wave_cust_key = obh.obh_cust_key
AND wd.wave_item_key = obd.obd_itm_key
AND wd.wave_so_no 	 = obh.oub_prim_rf_dc_no
LEFT JOIN dwh.f_waveheader wh
ON  wd.wave_hdr_key = wh.wave_hdr_key
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
		
	EXCEPTION WHEN others THEN       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert('CLICK','f_wmsoutboundorddetail','CLICK',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);
	

END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmsoutboundorddetail()
    OWNER TO proconnect;
