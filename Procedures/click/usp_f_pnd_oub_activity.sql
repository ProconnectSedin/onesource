-- PROCEDURE: click.usp_f_pnd_oub_activity()

-- DROP PROCEDURE IF EXISTS click.usp_f_pnd_oub_activity();

CREATE OR REPLACE PROCEDURE click.usp_f_pnd_oub_activity(
	)
LANGUAGE 'plpgsql'
AS $BODY$
	DECLARE 
		p_errorid integer;
		p_errordesc character varying;
		v_maxdate date;
	BEGIN

/*	SELECT 
		(
			CASE WHEN MAX(etlcreatedatetime) <> NULL
				 THEN MAX(etlcreatedatetime)
				 ELSE COALESCE(MAX(etlcreatedatetime),'1900-01-01')
			END
		)::DATE
		INTO v_maxdate
		FROM click.f_pnd_oub_activity;
	
	IF v_maxdate = '1900-01-01'
	THEN

		INSERT INTO click.f_pnd_oub_activity
			(
				obh_loc_key		, obh_cust_key		, obd_itm_key		,
				ou				, oub_date			, oub_loc			, customer		,
				order_no		, order_status		, invoice_type		, invoice_no	, 
				service_type	, line_no			, item_code			, item_qty		,
				wave_status		, 
				pick_status		, 
				pack_status		,
				wave_pln_end_date		,
				pick_exec_ml_end_date	,
				etlcreatedatetime		, etlupdatedatetime	, createdate
			)

		SELECT
			OBH.obh_loc_key			, OBH.obh_cust_key		, OBI.obd_itm_key		,
			OBH.oub_ou				, OBH.oub_orderdate		, OBH.oub_loc_code		, OBH.oub_cust_code		,
			OBH.oub_outbound_ord	, OBH.oub_ob_status		, OBH.oub_prim_rf_dc_typ, OBH.oub_prim_rf_dc_no	,
			OBH.oub_shipment_type	, OBI.oub_itm_lineno	, OBI.oub_item_code		, OBI.oub_itm_order_qty	,
			COALESCE(WH.wave_status, 'PENDING')				,
			COALESCE(PH.pick_exec_status, 'PENDING')		,
			COALESCE(PEH.pack_exec_status, 'PENDING')		,
			MAX(WH.wave_pln_end_date)		,
			MAX(PD.pick_exec_ml_end_date)	,
			MAX(OBH.etlcreatedatetime)		, MAX(OBH.etlupdatedatetime)	, NOW()

		FROM dwh.f_outboundheader OBH
		INNER JOIN dwh.f_outbounditemdetail OBI
			ON	OBH.obh_hr_key		= OBI.obh_hr_key
		LEFT JOIN dwh.f_wavedetail WD
			ON  WD.wave_loc_key  	= OBH.obh_loc_key
			AND WD.wave_cust_key 	= OBH.obh_cust_key
			AND  WD.wave_so_no		= OBH.oub_prim_rf_dc_no
		LEFT JOIN dwh.f_waveheader WH
			ON  WD.wave_hdr_key		= WH.wave_hdr_key	
		LEFT JOIN dwh.f_pickingdetail PD
			ON	WD.wave_loc_key		= PD.pick_loc_key
			AND	WD.wave_so_no		= PD.pick_so_no 
		LEFT JOIN dwh.f_pickingheader PH
			ON	PH.pick_hdr_key		= PD.pick_hdr_key
		LEFT JOIN dwh.f_packexecthudetail PETD
			ON	PETD.pack_so_no			= PD.pick_so_no
			AND PETD.pack_so_line_no	= PD.pick_so_line_no
		LEFT JOIN dwh.f_packexecheader PEH
			ON	PETD.pack_exec_hdr_key	= PEH.pack_exe_hdr_key

		WHERE	PEH.pack_exec_status NOT IN ('CMPD', 'STCLS')

		GROUP BY
			OBH.obh_loc_key			, OBH.obh_cust_key		, OBI.obd_itm_key		,
			OBH.oub_ou				, OBH.oub_orderdate		, OBH.oub_loc_code		, OBH.oub_cust_code		,
			OBH.oub_outbound_ord	, OBH.oub_ob_status		, OBH.oub_prim_rf_dc_typ, OBH.oub_prim_rf_dc_no	,
			OBH.oub_shipment_type	, OBI.oub_itm_lineno	, OBI.oub_item_code		, OBI.oub_itm_order_qty	,
			COALESCE(WH.wave_status, 'PENDING')		,
			COALESCE(PH.pick_exec_status, 'PENDING'),
			COALESCE(PEH.pack_exec_status, 'PENDING');

	ELSE

		DELETE FROM click.f_pnd_oub_activity
		WHERE etlcreatedatetime::DATE >= v_maxdate;
*/

		TRUNCATE TABLE click.f_pnd_oub_activity 
		RESTART IDENTITY;
		
		
		INSERT INTO click.f_pnd_oub_activity
			(
				obh_loc_key		, obh_cust_key		, obd_itm_key		,
				ou				, oub_date			, oub_loc			, customer		,
				order_no		, order_status		, invoice_type		, invoice_no	, 
				service_type	, line_no			, item_code			, item_qty		,
				wave_status		, 
				pick_status		, 
				pack_status		,
				wave_pln_end_date		,
				pick_exec_ml_end_date	,
				etlcreatedatetime		, etlupdatedatetime	, createdate
			)
	
		SELECT
			OBH.obh_loc_key			, OBH.obh_cust_key		, OBI.obd_itm_key		,
			OBH.oub_ou				, OBH.oub_orderdate		, OBH.oub_loc_code		, OBH.oub_cust_code		,
			OBH.oub_outbound_ord	, OBH.oub_ob_status		, OBH.oub_prim_rf_dc_typ, OBH.oub_prim_rf_dc_no	,
			OBH.oub_shipment_type	, OBI.oub_itm_lineno	, OBI.oub_item_code		, OBI.oub_itm_order_qty	,
			COALESCE(WH.wave_status, 'PENDING')				,
			COALESCE(PH.pick_exec_status, 'PENDING')		,
			COALESCE(PEH.pack_exec_status, 'PENDING')		,
			MAX(WH.wave_pln_end_date)		,
			MAX(PD.pick_exec_ml_end_date)	,
			MAX(OBH.etlcreatedatetime)		, MAX(OBH.etlupdatedatetime)	, NOW()
			
		FROM dwh.f_outboundheader OBH
		INNER JOIN dwh.f_outbounditemdetail OBI
			ON	OBH.obh_hr_key		= OBI.obh_hr_key
		LEFT JOIN dwh.f_wavedetail WD
			ON  WD.wave_loc_key  	= OBH.obh_loc_key
			AND WD.wave_cust_key 	= OBH.obh_cust_key
			AND  WD.wave_so_no		= OBH.oub_prim_rf_dc_no
		LEFT JOIN dwh.f_waveheader WH
			ON  WD.wave_hdr_key		= WH.wave_hdr_key
		LEFT JOIN dwh.f_pickingdetail PD
			ON	WD.wave_loc_key		= PD.pick_loc_key
			AND	WD.wave_so_no		= PD.pick_so_no
		LEFT JOIN dwh.f_pickingheader PH
			ON	PH.pick_hdr_key		= PD.pick_hdr_key
		LEFT JOIN dwh.f_packexecthudetail PETD
			ON PETD.pack_exec_loc_key	= PD.pick_loc_key
			AND PETD.pack_so_no			= PD.pick_so_no
			AND PETD.pack_so_line_no	= PD.pick_so_line_no
		LEFT JOIN dwh.f_packexecheader PEH
			ON	PETD.pack_exec_hdr_key	= PEH.pack_exe_hdr_key
		WHERE	PEH.pack_exec_status NOT IN ('CMPD', 'STCLS')
-- 			AND	OBH.etlcreatedatetime::DATE >= v_maxdate
			
		GROUP BY
			OBH.obh_loc_key			, OBH.obh_cust_key		, OBI.obd_itm_key		,
			OBH.oub_ou				, OBH.oub_orderdate		, OBH.oub_loc_code		, OBH.oub_cust_code		,
			OBH.oub_outbound_ord	, OBH.oub_ob_status		, OBH.oub_prim_rf_dc_typ, OBH.oub_prim_rf_dc_no	,
			OBH.oub_shipment_type	, OBI.oub_itm_lineno	, OBI.oub_item_code		, OBI.oub_itm_order_qty	,
			COALESCE(WH.wave_status, 'PENDING')		,
			COALESCE(PH.pick_exec_status, 'PENDING'),
			COALESCE(PEH.pack_exec_status, 'PENDING');
	
-- 	END IF;
		
		EXCEPTION WHEN others THEN       

		GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

		CALL ods.usp_etlerrorinsert('DWH','f_pnd_oub_activity','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);
  
	END;
	
$BODY$;
ALTER PROCEDURE click.usp_f_pnd_oub_activity()
    OWNER TO proconnect;
