-- PROCEDURE: click.usp_f_packexecthudetail()

-- DROP PROCEDURE IF EXISTS click.usp_f_packexecthudetail();

CREATE OR REPLACE PROCEDURE click.usp_f_packexecthudetail(
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
	FROM CLICK.f_packexecthudetail;

	IF v_maxdate = '1900-01-01'

	THEN

	INSERT INTO click.f_packexecthudetail
		(
			pack_exec_thu_dtl_key	, pack_exec_hdr_key		, pack_exec_thu_hdr_key	, pack_exec_itm_hdr_key, 
			pack_exec_loc_key		, pack_exec_thu_key		, pack_loc_code			, pack_exec_no, 
			pack_exec_ou			, pack_thu_id			, pack_thu_lineno		, pack_thu_ser_no, 
			pack_picklist_no		, pack_so_no			, pack_so_line_no		, pack_so_sch_lineno, 
			pack_thu_item_code		, pack_thu_item_qty		, pack_thu_pack_qty		, pack_thu_item_batch_no, 
			pack_thu_item_sr_no		, pack_lot_no			, pack_uid1_ser_no		, pack_uid_ser_no, 
			pack_allocated_qty		, pack_planned_qty		, pack_tolerance_qty	, pack_packed_from_uid_serno, 
			pack_factory_pack		, pack_source_thu_ser_no, pack_reason_code		, etlactiveind, 
			etljobname				, envsourcecd			, datasourcecd			, etlcreatedatetime, 
			etlupdatedatetime		, createddate
		)
	SELECT DISTINCT
			pack_exec_thu_dtl_key	, pack_exec_hdr_key		, pack_exec_thu_hdr_key	, pack_exec_itm_hdr_key, 
			pack_exec_loc_key		, pack_exec_thu_key		, pack_loc_code			, pack_exec_no, 
			pack_exec_ou			, pack_thu_id			, pack_thu_lineno		, pack_thu_ser_no, 
			pack_picklist_no		, pack_so_no			, pack_so_line_no		, pack_so_sch_lineno, 
			pack_thu_item_code		, pack_thu_item_qty		, pack_thu_pack_qty		, pack_thu_item_batch_no, 
			pack_thu_item_sr_no		, pack_lot_no			, pack_uid1_ser_no		, pack_uid_ser_no, 
			pack_allocated_qty		, pack_planned_qty		, pack_tolerance_qty	, pack_packed_from_uid_serno, 
			pack_factory_pack		, pack_source_thu_ser_no, pack_reason_code		, etlactiveind, 
			etljobname				, envsourcecd			, datasourcecd			, etlcreatedatetime, 
			etlupdatedatetime		, NOW()
	FROM dwh.f_packexecthudetail;

	ELSE
		
	UPDATE click.f_packexecthudetail CPED
	SET
		pack_exec_thu_dtl_key		= PED.pack_exec_thu_dtl_key,
		pack_exec_hdr_key			= PED.pack_exec_hdr_key,
		pack_exec_thu_hdr_key		= PED.pack_exec_thu_hdr_key,
		pack_exec_itm_hdr_key		= PED.pack_exec_itm_hdr_key,
		pack_exec_loc_key			= PED.pack_exec_loc_key,
		pack_exec_thu_key			= PED.pack_exec_thu_key,
		pack_loc_code				= PED.pack_loc_code,
		pack_exec_no				= PED.pack_exec_no,
		pack_exec_ou				= PED.pack_exec_ou,
		pack_thu_id					= PED.pack_thu_id,
		pack_thu_lineno				= PED.pack_thu_lineno,
		pack_thu_ser_no				= PED.pack_thu_ser_no,
		pack_picklist_no			= PED.pack_picklist_no,
		pack_so_no					= PED.pack_so_no,
		pack_so_line_no				= PED.pack_so_line_no,
		pack_so_sch_lineno			= PED.pack_so_sch_lineno,
		pack_thu_item_code			= PED.pack_thu_item_code,
		pack_thu_item_qty			= PED.pack_thu_item_qty,
		pack_thu_pack_qty			= PED.pack_thu_pack_qty,
		pack_thu_item_batch_no		= PED.pack_thu_item_batch_no,
		pack_thu_item_sr_no			= PED.pack_thu_item_sr_no,
		pack_lot_no					= PED.pack_lot_no,
		pack_uid1_ser_no			= PED.pack_uid1_ser_no,
		pack_uid_ser_no				= PED.pack_uid_ser_no,
		pack_allocated_qty			= PED.pack_allocated_qty,
		pack_planned_qty			= PED.pack_planned_qty,
		pack_tolerance_qty			= PED.pack_tolerance_qty,
		pack_packed_from_uid_serno	= PED.pack_packed_from_uid_serno,
		pack_factory_pack			= PED.pack_factory_pack,
		pack_source_thu_ser_no		= PED.pack_source_thu_ser_no,
		pack_reason_code			= PED.pack_reason_code,
		etlactiveind				= PED.etlactiveind,
		etljobname					= PED.etljobname,
		envsourcecd					= PED.envsourcecd,
		datasourcecd				= PED.datasourcecd,
		etlcreatedatetime			= PED.etlcreatedatetime,
		etlupdatedatetime			= PED.etlupdatedatetime,
		updatedatetime				= NOW()
	FROM dwh.f_packexecthudetail PED
	WHERE CPED.pack_exec_thu_dtl_key = PED.pack_exec_thu_dtl_key
	AND COALESCE(PED.etlupdatedatetime,PED.etlcreatedatetime) >= v_maxdate;

	INSERT INTO click.f_packexecthudetail
		(
			pack_exec_thu_dtl_key	, pack_exec_hdr_key		, pack_exec_thu_hdr_key	, pack_exec_itm_hdr_key, 
			pack_exec_loc_key		, pack_exec_thu_key		, pack_loc_code			, pack_exec_no, 
			pack_exec_ou			, pack_thu_id			, pack_thu_lineno		, pack_thu_ser_no, 
			pack_picklist_no		, pack_so_no			, pack_so_line_no		, pack_so_sch_lineno, 
			pack_thu_item_code		, pack_thu_item_qty		, pack_thu_pack_qty		, pack_thu_item_batch_no, 
			pack_thu_item_sr_no		, pack_lot_no			, pack_uid1_ser_no		, pack_uid_ser_no, 
			pack_allocated_qty		, pack_planned_qty		, pack_tolerance_qty	, pack_packed_from_uid_serno, 
			pack_factory_pack		, pack_source_thu_ser_no, pack_reason_code		, etlactiveind, 
			etljobname				, envsourcecd			, datasourcecd			, etlcreatedatetime, 
			etlupdatedatetime		, createddate
		)
	SELECT DISTINCT
			PED.pack_exec_thu_dtl_key	, PED.pack_exec_hdr_key		, PED.pack_exec_thu_hdr_key	, PED.pack_exec_itm_hdr_key, 
			PED.pack_exec_loc_key		, PED.pack_exec_thu_key		, PED.pack_loc_code			, PED.pack_exec_no, 
			PED.pack_exec_ou			, PED.pack_thu_id			, PED.pack_thu_lineno		, PED.pack_thu_ser_no, 
			PED.pack_picklist_no		, PED.pack_so_no			, PED.pack_so_line_no		, PED.pack_so_sch_lineno, 
			PED.pack_thu_item_code		, PED.pack_thu_item_qty		, PED.pack_thu_pack_qty		, PED.pack_thu_item_batch_no, 
			PED.pack_thu_item_sr_no		, PED.pack_lot_no			, PED.pack_uid1_ser_no		, PED.pack_uid_ser_no, 
			PED.pack_allocated_qty		, PED.pack_planned_qty		, PED.pack_tolerance_qty	, PED.pack_packed_from_uid_serno, 
			PED.pack_factory_pack		, PED.pack_source_thu_ser_no, PED.pack_reason_code		, PED.etlactiveind, 
			PED.etljobname				, PED.envsourcecd			, PED.datasourcecd			, PED.etlcreatedatetime, 
			PED.etlupdatedatetime		, NOW()
	FROM dwh.f_packexecthudetail PED
	LEFT JOIN CLICK.f_packexecthudetail CPED
	ON CPED.pack_exec_thu_dtl_key = PED.pack_exec_thu_dtl_key
	WHERE COALESCE(PED.etlupdatedatetime,PED.etlcreatedatetime) >= v_maxdate
	AND CPED.pack_exec_thu_dtl_key IS NULL;

END IF;

	EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','f_packexecthudetail','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);
  
END;
$BODY$;
ALTER PROCEDURE click.usp_f_packexecthudetail()
    OWNER TO proconnect;
