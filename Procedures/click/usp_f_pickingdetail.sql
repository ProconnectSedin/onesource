-- PROCEDURE: click.usp_f_pickingdetail()

-- DROP PROCEDURE IF EXISTS click.usp_f_pickingdetail();

CREATE OR REPLACE PROCEDURE click.usp_f_pickingdetail(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	v_maxdate date;
BEGIN

	SELECT COALESCE(MAX(etlcreatedatetime),'1900-01-01')::DATE	
	INTO v_maxdate
	FROM CLICK.f_pickingdetail;

	IF v_maxdate = '1900-01-01'

	THEN

	INSERT INTO CLICK.f_pickingdetail
	(
		pick_dtl_key			, pick_hdr_key			, pick_loc_key				, pick_loc_code, 
		pick_exec_no			, pick_exec_ou			, pick_lineno				, pick_wave_no,
		pick_so_no				, pick_so_line_no		, pick_sch_lineno			, pick_so_qty, 
		pick_item_code			, pick_item_batch_no	, pick_item_sr_no			, pick_uid_sr_no, 
		pick_qty				, pick_zone				, pick_bin					, pick_bin_qty, 
		pick_plan_line_no		, pick_reason_code		, pick_allc_line_no			, pick_lot_no, 
		pick_su					, pick_su_serial_no		, pick_su_type				, pick_thu_id, 
		pick_allocated_qty		, pick_thu_serial_no	, pick_urgent_cb			, pick_exec_thu_wt, 
		pick_exec_thu_wt_uom	, pick_length			, pick_breadth				, pick_height, 
		pick_uom				, pick_volumeuom		, pick_volume				, pick_weightuom, 
		pick_thuweight			, pick_customerserialno	, pick_warrantyserialno		, pick_counted_blnceqty,
		pick_staging_id			, pick_source_thu_id	, pick_source_thu_serial_no	, pick_cross_dk_staging_id, 
		pick_stock_status		, pick_outbound_no		, pick_customer_code		, pick_customer_item_code, 
		gift_card_serial_no		, warranty_serial_no	, pick_ser_flag				, pick_ser_date,
		pick_su2				, pick_uom1				, pick_su_serial_no2		, pick_system_date, 
		pick_exec_ml_start_date	, pick_exec_ml_end_date	, pick_targetlocation		, pick_item_attribute1, 
		etlactiveind			, etljobname			, envsourcecd				, datasourcecd, 
		etlcreatedatetime		, etlupdatedatetime		, pick_itm_key				, createddate
	)
	SELECT
		dpd.pick_dtl_key			, dpd.pick_hdr_key			, dpd.pick_loc_key				, dpd.pick_loc_code, 
		dpd.pick_exec_no			, dpd.pick_exec_ou			, dpd.pick_lineno				, dpd.pick_wave_no,
		dpd.pick_so_no				, dpd.pick_so_line_no		, dpd.pick_sch_lineno			, dpd.pick_so_qty, 
		dpd.pick_item_code			, dpd.pick_item_batch_no	, dpd.pick_item_sr_no			, dpd.pick_uid_sr_no, 
		dpd.pick_qty				, dpd.pick_zone				, dpd.pick_bin					, dpd.pick_bin_qty, 
		dpd.pick_plan_line_no		, dpd.pick_reason_code		, dpd.pick_allc_line_no			, dpd.pick_lot_no, 
		dpd.pick_su					, dpd.pick_su_serial_no		, dpd.pick_su_type				, dpd.pick_thu_id, 
		dpd.pick_allocated_qty		, dpd.pick_thu_serial_no	, dpd.pick_urgent_cb			, dpd.pick_exec_thu_wt, 
		dpd.pick_exec_thu_wt_uom	, dpd.pick_length			, dpd.pick_breadth				, dpd.pick_height, 
		dpd.pick_uom				, dpd.pick_volumeuom		, dpd.pick_volume				, dpd.pick_weightuom, 
		dpd.pick_thuweight			, dpd.pick_customerserialno	, dpd.pick_warrantyserialno		, dpd.pick_counted_blnceqty,
		dpd.pick_staging_id			, dpd.pick_source_thu_id	, dpd.pick_source_thu_serial_no	, dpd.pick_cross_dk_staging_id, 
		dpd.pick_stock_status		, dpd.pick_outbound_no		, dpd.pick_customer_code		, dpd.pick_customer_item_code, 
		dpd.gift_card_serial_no		, dpd.warranty_serial_no	, dpd.pick_ser_flag				, dpd.pick_ser_date,
		dpd.pick_su2				, dpd.pick_uom1				, dpd.pick_su_serial_no2		, dpd.pick_system_date, 
		dpd.pick_exec_ml_start_date	, dpd.pick_exec_ml_end_date	, dpd.pick_targetlocation		, dpd.pick_item_attribute1, 
		dpd.etlactiveind			, dpd.etljobname			, dpd.envsourcecd				, dpd.datasourcecd, 
		dpd.etlcreatedatetime		, dpd.etlupdatedatetime		, dpd.pick_itm_key				, NOW()
	FROM dwh.f_pickingdetail dpd;

	ELSE

	UPDATE click.f_pickingdetail cpd
	SET
		pick_dtl_key				= pd.pick_dtl_key,
		pick_hdr_key				= pd.pick_hdr_key,
		pick_loc_key				= pd.pick_loc_key,
		pick_loc_code				= pd.pick_loc_code,
		pick_exec_no				= pd.pick_exec_no,
		pick_exec_ou				= pd.pick_exec_ou,
		pick_lineno					= pd.pick_lineno,
		pick_wave_no				= pd.pick_wave_no,
		pick_so_no					= pd.pick_so_no,
		pick_so_line_no				= pd.pick_so_line_no,
		pick_sch_lineno				= pd.pick_sch_lineno,
		pick_so_qty					= pd.pick_so_qty,
		pick_item_code				= pd.pick_item_code,
		pick_item_batch_no			= pd.pick_item_batch_no,
		pick_item_sr_no				= pd.pick_item_sr_no,
		pick_uid_sr_no				= pd.pick_uid_sr_no,
		pick_qty					= pd.pick_qty,
		pick_zone					= pd.pick_zone,
		pick_bin					= pd.pick_bin,
		pick_bin_qty				= pd.pick_bin_qty,
		pick_plan_line_no			= pd.pick_plan_line_no,
		pick_reason_code			= pd.pick_reason_code,
		pick_allc_line_no			= pd.pick_allc_line_no,
		pick_lot_no					= pd.pick_lot_no,
		pick_su						= pd.pick_su,
		pick_su_serial_no			= pd.pick_su_serial_no,
		pick_su_type				= pd.pick_su_type,
		pick_thu_id					= pd.pick_thu_id,
		pick_allocated_qty			= pd.pick_allocated_qty,
		pick_thu_serial_no			= pd.pick_thu_serial_no,
		pick_urgent_cb				= pd.pick_urgent_cb,
		pick_exec_thu_wt			= pd.pick_exec_thu_wt,
		pick_exec_thu_wt_uom		= pd.pick_exec_thu_wt_uom,
		pick_length					= pd.pick_length,
		pick_breadth				= pd.pick_breadth,
		pick_height					= pd.pick_height,
		pick_uom					= pd.pick_uom,
		pick_volumeuom				= pd.pick_volumeuom,
		pick_volume					= pd.pick_volume,
		pick_weightuom				= pd.pick_weightuom,
		pick_thuweight				= pd.pick_thuweight,
		pick_customerserialno		= pd.pick_customerserialno,
		pick_warrantyserialno		= pd.pick_warrantyserialno,
		pick_counted_blnceqty		= pd.pick_counted_blnceqty,
		pick_staging_id				= pd.pick_staging_id,
		pick_source_thu_id			= pd.pick_source_thu_id,
		pick_source_thu_serial_no	= pd.pick_source_thu_serial_no,
		pick_cross_dk_staging_id	= pd.pick_cross_dk_staging_id,
		pick_stock_status			= pd.pick_stock_status,
		pick_outbound_no			= pd.pick_outbound_no,
		pick_customer_code			= pd.pick_customer_code,
		pick_customer_item_code		= pd.pick_customer_item_code,
		gift_card_serial_no			= pd.gift_card_serial_no,
		warranty_serial_no			= pd.warranty_serial_no,
		pick_ser_flag				= pd.pick_ser_flag,
		pick_ser_date				= pd.pick_ser_date,
		pick_su2					= pd.pick_su2,
		pick_uom1					= pd.pick_uom1,
		pick_su_serial_no2			= pd.pick_su_serial_no2,
		pick_system_date			= pd.pick_system_date,
		pick_exec_ml_start_date		= pd.pick_exec_ml_start_date,
		pick_exec_ml_end_date		= pd.pick_exec_ml_end_date,
		pick_targetlocation			= pd.pick_targetlocation,
		pick_item_attribute1		= pd.pick_item_attribute1,
		etlactiveind				= pd.etlactiveind,
		etljobname					= pd.etljobname,
		envsourcecd					= pd.envsourcecd,
		datasourcecd				= pd.datasourcecd,
		etlcreatedatetime			= pd.etlcreatedatetime,
		etlupdatedatetime			= pd.etlupdatedatetime,
		pick_itm_key				= pd.pick_itm_key,
		updatedatetime				= NOW()
	FROM dwh.f_pickingdetail pd
	WHERE cpd.pick_dtl_key			= pd.pick_dtl_key
	AND COALESCE(pd.etlupdatedatetime, pd.etlcreatedatetime) >= v_maxdate;

	INSERT INTO CLICK.f_pickingdetail
	(
		pick_dtl_key			, pick_hdr_key			, pick_loc_key				, pick_loc_code, 
		pick_exec_no			, pick_exec_ou			, pick_lineno				, pick_wave_no,
		pick_so_no				, pick_so_line_no		, pick_sch_lineno			, pick_so_qty, 
		pick_item_code			, pick_item_batch_no	, pick_item_sr_no			, pick_uid_sr_no, 
		pick_qty				, pick_zone				, pick_bin					, pick_bin_qty, 
		pick_plan_line_no		, pick_reason_code		, pick_allc_line_no			, pick_lot_no, 
		pick_su					, pick_su_serial_no		, pick_su_type				, pick_thu_id, 
		pick_allocated_qty		, pick_thu_serial_no	, pick_urgent_cb			, pick_exec_thu_wt, 
		pick_exec_thu_wt_uom	, pick_length			, pick_breadth				, pick_height, 
		pick_uom				, pick_volumeuom		, pick_volume				, pick_weightuom, 
		pick_thuweight			, pick_customerserialno	, pick_warrantyserialno		, pick_counted_blnceqty,
		pick_staging_id			, pick_source_thu_id	, pick_source_thu_serial_no	, pick_cross_dk_staging_id, 
		pick_stock_status		, pick_outbound_no		, pick_customer_code		, pick_customer_item_code, 
		gift_card_serial_no		, warranty_serial_no	, pick_ser_flag				, pick_ser_date,
		pick_su2				, pick_uom1				, pick_su_serial_no2		, pick_system_date, 
		pick_exec_ml_start_date	, pick_exec_ml_end_date	, pick_targetlocation		, pick_item_attribute1, 
		etlactiveind			, etljobname			, envsourcecd				, datasourcecd, 
		etlcreatedatetime		, etlupdatedatetime		, pick_itm_key				, createddate
	)
	SELECT
		dpd.pick_dtl_key			, dpd.pick_hdr_key			, dpd.pick_loc_key				, dpd.pick_loc_code, 
		dpd.pick_exec_no			, dpd.pick_exec_ou			, dpd.pick_lineno				, dpd.pick_wave_no,
		dpd.pick_so_no				, dpd.pick_so_line_no		, dpd.pick_sch_lineno			, dpd.pick_so_qty, 
		dpd.pick_item_code			, dpd.pick_item_batch_no	, dpd.pick_item_sr_no			, dpd.pick_uid_sr_no, 
		dpd.pick_qty				, dpd.pick_zone				, dpd.pick_bin					, dpd.pick_bin_qty, 
		dpd.pick_plan_line_no		, dpd.pick_reason_code		, dpd.pick_allc_line_no			, dpd.pick_lot_no, 
		dpd.pick_su					, dpd.pick_su_serial_no		, dpd.pick_su_type				, dpd.pick_thu_id, 
		dpd.pick_allocated_qty		, dpd.pick_thu_serial_no	, dpd.pick_urgent_cb			, dpd.pick_exec_thu_wt, 
		dpd.pick_exec_thu_wt_uom	, dpd.pick_length			, dpd.pick_breadth				, dpd.pick_height, 
		dpd.pick_uom				, dpd.pick_volumeuom		, dpd.pick_volume				, dpd.pick_weightuom, 
		dpd.pick_thuweight			, dpd.pick_customerserialno	, dpd.pick_warrantyserialno		, dpd.pick_counted_blnceqty,
		dpd.pick_staging_id			, dpd.pick_source_thu_id	, dpd.pick_source_thu_serial_no	, dpd.pick_cross_dk_staging_id, 
		dpd.pick_stock_status		, dpd.pick_outbound_no		, dpd.pick_customer_code		, dpd.pick_customer_item_code, 
		dpd.gift_card_serial_no		, dpd.warranty_serial_no	, dpd.pick_ser_flag				, dpd.pick_ser_date,
		dpd.pick_su2				, dpd.pick_uom1				, dpd.pick_su_serial_no2		, dpd.pick_system_date, 
		dpd.pick_exec_ml_start_date	, dpd.pick_exec_ml_end_date	, dpd.pick_targetlocation		, dpd.pick_item_attribute1, 
		dpd.etlactiveind			, dpd.etljobname			, dpd.envsourcecd				, dpd.datasourcecd, 
		dpd.etlcreatedatetime		, dpd.etlupdatedatetime		, dpd.pick_itm_key				, NOW()
	FROM dwh.f_pickingdetail dpd
	LEFT JOIN CLICK.f_pickingdetail pd
	ON dpd.pick_dtl_key	= pd.pick_dtl_key
	WHERE COALESCE(pd.etlupdatedatetime, pd.etlcreatedatetime) >= v_maxdate
	AND dpd.pick_dtl_key IS NULL;

	END IF;

	EXCEPTION WHEN others THEN       

    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

    CALL ods.usp_etlerrorinsert('DWH','f_pickingdetail','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;
ALTER PROCEDURE click.usp_f_pickingdetail()
    OWNER TO proconnect;
