-- PROCEDURE: click.usp_f_pickingheader()

-- DROP PROCEDURE IF EXISTS click.usp_f_pickingheader();

CREATE OR REPLACE PROCEDURE click.usp_f_pickingheader(
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
	FROM CLICK.F_PickingHeader;

	IF v_maxdate = '1900-01-01'

	THEN

    INSERT INTO click.F_PickingHeader
	(	pick_hdr_key		,
		pick_loc_code		, pick_exec_no		, pick_exec_ou			, pick_loc_key,
		pick_exec_date		, pick_exec_status	, pick_pln_no			, pick_employee,
		pick_mhe			, pick_staging_id	, pick_exec_start_date	, pick_exec_end_date,
		pick_created_by		, pick_created_date	, pick_modified_by		, pick_modified_date,
		pick_timestamp		, pick_steps		, pk_exe_urgent_cb		, pick_gen_from,
		pick_pln_type		, pick_zone_pickby	, pick_reset_flg		, pick_system_date,
		etlactiveind		, etljobname		, envsourcecd			, datasourcecd,
		etlupdatedatetime	, etlcreatedatetime	, createddate	
	)

	SELECT
		ph.pick_hdr_key			,
		ph.pick_loc_code		, ph.pick_exec_no		, ph.pick_exec_ou			, ph.pick_loc_key,
		ph.pick_exec_date		, ph.pick_exec_status	, ph.pick_pln_no			, ph.pick_employee,
		ph.pick_mhe				, ph.pick_staging_id	, ph.pick_exec_start_date	, ph.pick_exec_end_date,
		ph.pick_created_by		, ph.pick_created_date	, ph.pick_modified_by		, ph.pick_modified_date,
		ph.pick_timestamp		, ph.pick_steps			, ph.pk_exe_urgent_cb		, ph.pick_gen_from,
		ph.pick_pln_type		, ph.pick_zone_pickby	, ph.pick_reset_flg			, ph.pick_system_date,
		ph.etlactiveind			, ph.etljobname			, ph.envsourcecd			, ph.datasourcecd,
		ph.etlupdatedatetime	, ph.etlcreatedatetime	, NOW()
    FROM dwh.F_PickingHeader ph;

	ELSE

    UPDATE click.F_PickingHeader cph
    SET
		pick_hdr_key				= ph.pick_hdr_key,
		pick_loc_code				= ph.pick_loc_code,
		pick_exec_no				= ph.pick_exec_no,
		pick_exec_ou				= ph.pick_exec_ou,
		pick_loc_key				= ph.pick_loc_key,
        pick_exec_date              = ph.pick_exec_date,
        pick_exec_status            = ph.pick_exec_status,
        pick_pln_no                 = ph.pick_pln_no,
        pick_employee               = ph.pick_employee,
        pick_mhe                    = ph.pick_mhe,
        pick_staging_id             = ph.pick_staging_id,
        pick_exec_start_date        = ph.pick_exec_start_date,
        pick_exec_end_date          = ph.pick_exec_end_date,
        pick_created_by             = ph.pick_created_by,
        pick_created_date           = ph.pick_created_date,
        pick_modified_by            = ph.pick_modified_by,
        pick_modified_date          = ph.pick_modified_date,
        pick_timestamp              = ph.pick_timestamp,
        pick_steps                  = ph.pick_steps,
        pk_exe_urgent_cb            = ph.pk_exe_urgent_cb,
        pick_gen_from               = ph.pick_gen_from,
        pick_pln_type               = ph.pick_pln_type,
        pick_zone_pickby            = ph.pick_zone_pickby,
        pick_reset_flg              = ph.pick_reset_flg,
        pick_system_date            = ph.pick_system_date,
        etlactiveind                = ph.etlactiveind,
        etljobname                  = ph.etljobname,
        envsourcecd                 = ph.envsourcecd,
        datasourcecd                = ph.datasourcecd,
        etlupdatedatetime           = ph.etlupdatedatetime,
		etlcreatedatetime			= ph.etlcreatedatetime,
		updatedatetime				= NOW()
    FROM dwh.F_PickingHeader ph
	WHERE cph.pick_hdr_key			= ph.pick_hdr_key
	AND COALESCE(ph.etlupdatedatetime,ph.etlcreatedatetime) >= v_maxdate;

    INSERT INTO click.F_PickingHeader
	(
		pick_hdr_key		,
		pick_loc_code		, pick_exec_no		, pick_exec_ou			, pick_loc_key,
		pick_exec_date		, pick_exec_status	, pick_pln_no			, pick_employee,
		pick_mhe			, pick_staging_id	, pick_exec_start_date	, pick_exec_end_date,
		pick_created_by		, pick_created_date	, pick_modified_by		, pick_modified_date,
		pick_timestamp		, pick_steps		, pk_exe_urgent_cb		, pick_gen_from,
		pick_pln_type		, pick_zone_pickby	, pick_reset_flg		, pick_system_date,
		etlactiveind		, etljobname		, envsourcecd			, datasourcecd,
		etlupdatedatetime	, etlcreatedatetime	, createddate	
	)

	SELECT
		ph.pick_hdr_key			,
		ph.pick_loc_code		, ph.pick_exec_no		, ph.pick_exec_ou			, ph.pick_loc_key,
		ph.pick_exec_date		, ph.pick_exec_status	, ph.pick_pln_no			, ph.pick_employee,
		ph.pick_mhe				, ph.pick_staging_id	, ph.pick_exec_start_date	, ph.pick_exec_end_date,
		ph.pick_created_by		, ph.pick_created_date	, ph.pick_modified_by		, ph.pick_modified_date,
		ph.pick_timestamp		, ph.pick_steps			, ph.pk_exe_urgent_cb		, ph.pick_gen_from,
		ph.pick_pln_type		, ph.pick_zone_pickby	, ph.pick_reset_flg			, ph.pick_system_date,
		ph.etlactiveind			, ph.etljobname			, ph.envsourcecd			, ph.datasourcecd,
		ph.etlupdatedatetime	, ph.etlcreatedatetime	, NOW()
    FROM dwh.F_PickingHeader ph
	LEFT JOIN click.F_PickingHeader cph
	ON cph.pick_hdr_key			= ph.pick_hdr_key
	WHERE COALESCE(ph.etlupdatedatetime,ph.etlcreatedatetime) >= v_maxdate
	AND cph.pick_hdr_key is null;
		
END IF;

	EXCEPTION WHEN others THEN

    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

    CALL ods.usp_etlerrorinsert('DWH','F_PickingHeader','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;
ALTER PROCEDURE click.usp_f_pickingheader()
    OWNER TO proconnect;
