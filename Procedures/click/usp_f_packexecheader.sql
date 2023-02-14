-- PROCEDURE: click.usp_f_packexecheader()

-- DROP PROCEDURE IF EXISTS click.usp_f_packexecheader();

CREATE OR REPLACE PROCEDURE click.usp_f_packexecheader(
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
	FROM CLICK.f_packexecheader;

	IF v_maxdate = '1900-01-01'

	THEN

	INSERT INTO CLICK.f_packexecheader
	(
		pack_exe_hdr_key		, pack_loc_key			, pack_loc_code			, pack_exec_no,
		pack_exec_ou			, pack_exec_date		, pack_exec_status		, pack_pln_no,
		pack_employee			, pack_packing_bay		, pack_pre_pack_bay		, pack_created_by,
		pack_created_date		, pack_modified_by		, pack_modified_date	, pack_timestamp,
		pack_exec_start_date	, pack_exec_end_date	, pack_exe_urgent		,
		etlactiveind			, etljobname			, envsourcecd			, datasourcecd,
		etlcreatedatetime		, etlupdatedatetime		, createddate
	)
	SELECT
		ph.pack_exe_hdr_key		, ph.pack_loc_key		, ph.pack_loc_code		, ph.pack_exec_no,
		ph.pack_exec_ou			, ph.pack_exec_date		, ph.pack_exec_status	, ph.pack_pln_no,
		ph.pack_employee		, ph.pack_packing_bay	, ph.pack_pre_pack_bay	, ph.pack_created_by,
		ph.pack_created_date	, ph.pack_modified_by	, ph.pack_modified_date	, ph.pack_timestamp,
		ph.pack_exec_start_date	, ph.pack_exec_end_date	, ph.pack_exe_urgent	,
		ph.etlactiveind			, ph.etljobname			, ph.envsourcecd		, ph.datasourcecd,
		ph.etlcreatedatetime	, ph.etlupdatedatetime	, NOW()
	FROM DWH.f_packexecheader ph;

	ELSE

	UPDATE CLICK.f_packexecheader PEH
	SET
		pack_exe_hdr_key		= ph.pack_exe_hdr_key,
		pack_loc_key			= ph.pack_loc_key,
		pack_loc_code			= ph.pack_loc_code,
		pack_exec_no			= ph.pack_exec_no,
		pack_exec_ou			= ph.pack_exec_ou,
		pack_exec_date			= ph.pack_exec_date,
		pack_exec_status		= ph.pack_exec_status,
		pack_pln_no				= ph.pack_pln_no,
		pack_employee			= ph.pack_employee,
		pack_packing_bay		= ph.pack_packing_bay,
		pack_pre_pack_bay		= ph.pack_pre_pack_bay,
		pack_created_by			= ph.pack_created_by,
		pack_created_date		= ph.pack_created_date,
		pack_modified_by		= ph.pack_modified_by,
		pack_modified_date		= ph.pack_modified_date,
		pack_timestamp			= ph.pack_timestamp,
		pack_exec_start_date	= ph.pack_exec_start_date,
		pack_exec_end_date		= ph.pack_exec_end_date,
		pack_exe_urgent			= ph.pack_exe_urgent,
		etlactiveind			= ph.etlactiveind,
		etljobname				= ph.etljobname,
		envsourcecd				= ph.envsourcecd,
		datasourcecd			= ph.datasourcecd,
		etlcreatedatetime		= ph.etlcreatedatetime,
		etlupdatedatetime		= ph.etlupdatedatetime,
		updatedatetime			= NOW()
	FROM DWH.f_packexecheader ph
	WHERE PEH.pack_exe_hdr_key		= ph.pack_exe_hdr_key
	AND COALESCE (ph.etlcreatedatetime,ph.etlupdatedatetime) >= v_maxdate;
	
	INSERT INTO CLICK.f_packexecheader
	(
		pack_exe_hdr_key		, pack_loc_key			, pack_loc_code			, pack_exec_no,
		pack_exec_ou			, pack_exec_date		, pack_exec_status		, pack_pln_no,
		pack_employee			, pack_packing_bay		, pack_pre_pack_bay		, pack_created_by,
		pack_created_date		, pack_modified_by		, pack_modified_date	, pack_timestamp,
		pack_exec_start_date	, pack_exec_end_date	, pack_exe_urgent		,
		etlactiveind			, etljobname			, envsourcecd			, datasourcecd,
		etlcreatedatetime		, etlupdatedatetime		, createddate
	)
	SELECT
		ph.pack_exe_hdr_key		, ph.pack_loc_key		, ph.pack_loc_code		, ph.pack_exec_no,
		ph.pack_exec_ou			, ph.pack_exec_date		, ph.pack_exec_status	, ph.pack_pln_no,
		ph.pack_employee		, ph.pack_packing_bay	, ph.pack_pre_pack_bay	, ph.pack_created_by,
		ph.pack_created_date	, ph.pack_modified_by	, ph.pack_modified_date	, ph.pack_timestamp,
		ph.pack_exec_start_date	, ph.pack_exec_end_date	, ph.pack_exe_urgent	,
		ph.etlactiveind			, ph.etljobname			, ph.envsourcecd		, ph.datasourcecd,
		ph.etlcreatedatetime	, ph.etlupdatedatetime	, NOW()
	FROM DWH.f_packexecheader ph
	LEFT JOIN CLICK.f_packexecheader cph
	ON cph.pack_exe_hdr_key	= ph.pack_exe_hdr_key
	WHERE COALESCE(ph.etlcreatedatetime,ph.etlupdatedatetime) >= v_maxdate
	AND cph.pack_exe_hdr_key IS NULL;

	END IF;

	EXCEPTION WHEN others THEN       

    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

    CALL ods.usp_etlerrorinsert('DWH','f_packexecheader','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;
ALTER PROCEDURE click.usp_f_packexecheader()
    OWNER TO proconnect;
