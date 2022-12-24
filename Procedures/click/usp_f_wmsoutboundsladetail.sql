-- PROCEDURE: click.usp_f_wmsoutboundsladetail()

-- DROP PROCEDURE IF EXISTS click.usp_f_wmsoutboundsladetail();

CREATE OR REPLACE PROCEDURE click.usp_f_wmsoutboundsladetail(
	)
LANGUAGE 'plpgsql'
AS $BODY$
	DECLARE 
		p_errorid integer;
		p_errordesc character varying;
BEGIN

DELETE FROM click.f_outboundsladetail 
WHERE extract(year from sla_orderdate::Date) = 2022;
--sla_orderdate >= (NOW() - INTERVAL '3 MONTHS')::DATE;
--extract(year from sla_orderdate::Date) = 2022;
INSERT INTO click.f_outboundsladetail
(	
    sla_ou,
	sla_lockey,
	sla_ordkey,
	sla_loccode,
	sla_ordertype,
	sla_shipmenttype,
	sla_sono,
	sla_orderdate,
	sla_ordtime,
	sla_cutofftime,
	sla_pickexecdt,
	sla_packexecdt,
	sla_pickexpdt,
	sla_packexpdt,
	sla_processexpdt
)
SELECT 
			obh.oub_ou,
			obh.obh_loc_key,
			obh.obh_hr_key,
			obh.oub_loc_code,
			obh.oub_order_type,
			obh.oub_shipment_type,
			obh.oub_prim_rf_dc_no,
			MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date) :: DATE),
			MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date)::TIME),
			MAX(cutofftime),
			MAX(pick_exec_end_date),
			MAX(pack_exec_end_date),
			(CASE WHEN MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))::TIME < MAX(cutofftime)
			THEN 
			MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))::timestamp + (MAX(picktat) || ' Minutes')::INTERVAL
			ELSE 
			((MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))+ INTERVAL '1 DAY')::DATE ||' '||(MAX(openingtime)))::TIMESTAMP + (MAX(picktat) || ' Minutes')::INTERVAL 
			END )as PickExpclsdt,
			(CASE WHEN MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))::TIME < MAX(cutofftime)
			THEN 
			MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))::timestamp + (MAX(packtat) || ' Minutes')::INTERVAL
			ELSE 
			((MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))+ INTERVAL '1 DAY')::DATE ||' '||(MAX(openingtime)))::TIMESTAMP + (MAX(packtat) || ' Minutes')::INTERVAL 
			END )
			as PackExpclsdt,
			(CASE WHEN MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))::TIME < MAX(cutofftime) AND MAX(processtat)::INT = 0 
				THEN (MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))::DATE || (' 23:59:00.000'))::TIMESTAMP
				WHEN  MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))::TIME >= MAX(cutofftime) AND MAX(processtat)::INT = 0 
				THEN ((MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))+ INTERVAL '1 DAY')::DATE + MAX(cutofftime))::TIMESTAMP 
			 	WHEN  MAX(processtat)::INT <> 0 AND MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))::TIME < MAX(cutofftime) 
			 THEN MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))::TIMESTAMP + (MAX(processtat) || ' Minutes')::INTERVAL 
				WHEN  MAX(processtat)::INT <> 0 AND MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))::TIME >= MAX(cutofftime) 
			 THEN 
			 ((MAX(COALESCE(obh.oub_modified_date,obh.oub_created_date))+ INTERVAL '1 DAY')::DATE ||' '||(MAX(openingtime)))::TIMESTAMP + (MAX(processtat) || ' Minutes')::INTERVAL 
				END) ExpClosureDateTime
		FROM dwh.F_OutboundHeader obh
		INNER JOIN dwh.f_pickingdetail PickD
		ON  obh.oub_ou =  PickD.pick_exec_ou
		AND obh.obh_loc_key = PickD.pick_loc_key
		AND obh.oub_prim_rf_dc_no = PickD.pick_so_no
		INNER JOIN dwh.f_pickingheader PickH
		ON PickH.pick_hdr_key = PickD.pick_hdr_key
		INNER JOIN dwh.F_PackExecTHUDetail PackD
		ON  PackD.pack_exec_ou = PickD.pick_exec_ou
		AND PackD.pack_exec_loc_key  = PickD.pick_loc_key
		AND PackD.pack_so_no = pickD.pick_so_no
		INNER JOIN dwh.F_PackExecHeader PackH
		ON PackH.pack_exe_hdr_key = PackD.pack_exec_hdr_key
		LEFT JOIN dwh.D_WMSOutboundTAT TAT
		ON TAT.ou = obh.oub_ou
		AND TAT.locationcode = obh.oub_loc_code
		AND TAT.ordertype = obh.oub_order_type 
		AND TAT.servicetype = obh.oub_shipment_type
		LEFT JOIN dwh.D_OutboundLocShiftDetail shift
		ON TAT.ou = shift.ou
		AND TAT.locationcode = shift.locationcode
		AND TAT.ordertype = shift.ordertype 
		AND TAT.servicetype = shift.servicetype
		WHERE obh.oub_ob_status <> 'CN'
		--AND extract(year from COALESCE(obh.oub_modified_date,obh.oub_created_date)::Date) = 2022
		AND COALESCE(obh.oub_modified_date,obh.oub_created_date)::Date  >= (NOW() - INTERVAL '3 MONTHS')::DATE
		GROUP BY 
			obh.oub_ou,
			obh.obh_loc_key,
			obh.obh_hr_key,
			obh.oub_loc_code,
			obh.oub_order_type,
			obh.oub_shipment_type,
			obh.oub_prim_rf_dc_no;
			
UPDATE click.f_outboundsladetail SLA
SET 	sla_pickontimeflag = 	CASE WHEN sla_pickexecdt <= sla_pickexpdt THEN 1 
								WHEN sla_pickexecdt > sla_pickexpdt THEN 0
								ELSE NULL END,
		sla_packontimeflag =	CASE WHEN sla_packexecdt <= sla_packexpdt THEN 1 
								WHEN sla_packexecdt > sla_packexpdt THEN 0
								ELSE NULL END,
		sla_procontimeflag = 	CASE WHEN sla_packexecdt <= sla_processexpdt THEN 1 
								WHEN sla_packexecdt > sla_processexpdt THEN 0
								ELSE NULL END 	
--WHERE extract(year from sla_orderdate::Date)  = 2022;
WHERE SLA.sla_orderdate >= (NOW() - INTERVAL '3 MONTHS')::DATE;

UPDATE click.f_outboundsladetail SLA
SET SLA_Category 	= (CASE WHEN SLA_ProcONTimeFlag in (0,1) AND Remarks IS NOT NULL 
					   THEN 'Remarks' END
					   )
FROM dwh.F_DeliveryDelayReason DEL
--WHERE extract(year from sla_orderdate::Date)  = 2022
WHERE SLA.sla_orderdate >= (NOW() - INTERVAL '3 MONTHS')::DATE
AND DEL.tranou = SLA.sla_ou
AND DEL.locationcode = SLA.sla_loccode
AND DEL.invoiceno = SLA.sla_sono;

UPDATE click.f_outboundsladetail SLA
SET SLA_Category 	= (	CASE WHEN (sla_procontimeflag = 1) AND sla_ordtime >= sla_cutofftime THEN 'Premium'
							ELSE 'Achived'
						END)
WHERE SLA.sla_orderdate >= (NOW() - INTERVAL '3 MONTHS')::DATE
AND SLA_Category IS NULL;
--extract(year from sla_orderdate::Date)  = 2022
--WHERE SLA.sla_orderdate >= (NOW() - INTERVAL '3 MONTHS')::DATE;

UPDATE click.f_outboundsladetail SLA
SET SLA_Category = CASE WHEN SLA_ProcONTimeFlag = 0 THEN 'Breach' END
WHERE SLA.sla_orderdate >= (NOW() - INTERVAL '3 MONTHS')::DATE
AND SLA_Category IS NULL;

UPDATE click.f_outboundsladetail 
SET SLA_Category 	= 'Achived'	
--WHERE extract(year from sla_orderdate::Date)  = 2022
WHERE sla_orderdate >= (NOW() - INTERVAL '3 MONTHS')::DATE
AND sla_procontimeflag IS NULL
AND sla_processexpdt IS NULL
AND sla_packexecdt IS NOT NULL;

		EXCEPTION WHEN others THEN       

		GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

		CALL ods.usp_etlerrorinsert('CLICK','f_outboundsladetail','Click',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmsoutboundsladetail()
    OWNER TO proconnect;
