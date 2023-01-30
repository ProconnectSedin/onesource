-- PROCEDURE: click.usp_f_waveheader()

-- DROP PROCEDURE IF EXISTS click.usp_f_waveheader();

CREATE OR REPLACE PROCEDURE click.usp_f_waveheader(
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
	FROM CLICK.f_waveheader;

	IF v_maxdate = '1900-01-01'

	THEN

	INSERT INTO CLICK.f_waveheader
	(
		wave_hdr_key		, wave_loc_key			, wave_loc_code		, wave_no, 
		wave_ou				, wave_date				, wave_status		, wave_pln_start_date, 
		wave_pln_end_date	, wave_timestamp		, wave_created_by	, wave_created_date, 
		wave_modified_by	, wave_modified_date	, wave_alloc_rule	, wave_alloc_value, 
		wave_alloc_uom		, wave_no_of_pickers	, wave_gen_flag		, wave_staging_id, 
		wave_replenish_flag	, consolidated_flg		, etlactiveind		, etljobname, 
		envsourcecd			, datasourcecd			, etlcreatedatetime	, etlupdatedatetime, 
		createddate	
	)

	SELECT
		WH.wave_hdr_key			, WH.wave_loc_key			, WH.wave_loc_code		, WH.wave_no, 
		WH.wave_ou				, WH.wave_date				, WH.wave_status		, WH.wave_pln_start_date, 
		WH.wave_pln_end_date	, WH.wave_timestamp			, WH.wave_created_by	, WH.wave_created_date, 
		WH.wave_modified_by		, WH.wave_modified_date		, WH.wave_alloc_rule	, WH.wave_alloc_value, 
		WH.wave_alloc_uom		, WH.wave_no_of_pickers		, WH.wave_gen_flag		, WH.wave_staging_id, 
		WH.wave_replenish_flag	, WH.consolidated_flg		, WH.etlactiveind		, WH.etljobname, 
		WH.envsourcecd			, WH.datasourcecd			, WH.etlcreatedatetime	, WH.etlupdatedatetime, 
		NOW()
	FROM DWH.f_waveheader WH;
	
	ELSE

	UPDATE CLICK.f_waveheader CWH
	SET
		wave_hdr_key			= WH.wave_hdr_key,
		wave_loc_key			= WH.wave_loc_key,
		wave_loc_code			= WH.wave_loc_code,
		wave_no					= WH.wave_no,
		wave_ou					= WH.wave_ou,
		wave_date				= WH.wave_date,
		wave_status				= WH.wave_status,
		wave_pln_start_date		= WH.wave_pln_start_date,
		wave_pln_end_date		= WH.wave_pln_end_date,
		wave_timestamp			= WH.wave_timestamp,
		wave_created_by			= WH.wave_created_by,
		wave_created_date		= WH.wave_created_date,
		wave_modified_by		= WH.wave_modified_by,
		wave_modified_date		= WH.wave_modified_date,
		wave_alloc_rule			= WH.wave_alloc_rule,
		wave_alloc_value		= WH.wave_alloc_value,
		wave_alloc_uom			= WH.wave_alloc_uom,
		wave_no_of_pickers		= WH.wave_no_of_pickers,
		wave_gen_flag			= WH.wave_gen_flag,
		wave_staging_id			= WH.wave_staging_id,
		wave_replenish_flag		= WH.wave_replenish_flag,
		consolidated_flg		= WH.consolidated_flg,
		etlactiveind			= WH.etlactiveind,
		etljobname				= WH.etljobname,
		envsourcecd				= WH.envsourcecd,
		datasourcecd			= WH.datasourcecd,
		etlcreatedatetime		= WH.etlcreatedatetime,
		etlupdatedatetime		= WH.etlupdatedatetime,
		updatedatetime			= NOW()
	FROM DWH.f_waveheader WH
	WHERE CWH.wave_hdr_key		= WH.wave_hdr_key
	AND COALESCE(WH.etlupdatedatetime,WH.etlcreatedatetime) >= v_maxdate;

	INSERT INTO CLICK.f_waveheader
	(
		wave_hdr_key		, wave_loc_key			, wave_loc_code		, wave_no, 
		wave_ou				, wave_date				, wave_status		, wave_pln_start_date, 
		wave_pln_end_date	, wave_timestamp		, wave_created_by	, wave_created_date, 
		wave_modified_by	, wave_modified_date	, wave_alloc_rule	, wave_alloc_value, 
		wave_alloc_uom		, wave_no_of_pickers	, wave_gen_flag		, wave_staging_id, 
		wave_replenish_flag	, consolidated_flg		, etlactiveind		, etljobname, 
		envsourcecd			, datasourcecd			, etlcreatedatetime	, etlupdatedatetime, 
		createddate	
	)
	
	SELECT
		WH.wave_hdr_key			, WH.wave_loc_key			, WH.wave_loc_code		, WH.wave_no, 
		WH.wave_ou				, WH.wave_date				, WH.wave_status		, WH.wave_pln_start_date, 
		WH.wave_pln_end_date	, WH.wave_timestamp			, WH.wave_created_by	, WH.wave_created_date, 
		WH.wave_modified_by		, WH.wave_modified_date		, WH.wave_alloc_rule	, WH.wave_alloc_value, 
		WH.wave_alloc_uom		, WH.wave_no_of_pickers		, WH.wave_gen_flag		, WH.wave_staging_id, 
		WH.wave_replenish_flag	, WH.consolidated_flg		, WH.etlactiveind		, WH.etljobname, 
		WH.envsourcecd			, WH.datasourcecd			, WH.etlcreatedatetime	, WH.etlupdatedatetime, 
		NOW()
	FROM DWH.f_waveheader WH
	LEFT JOIN CLICK.f_waveheader CWH
	ON CWH.wave_hdr_key		= WH.wave_hdr_key
	WHERE COALESCE(WH.etlupdatedatetime,WH.etlcreatedatetime) >= v_maxdate
	AND CWH.wave_hdr_key IS NULL;
	
	END IF;
	
	EXCEPTION WHEN others THEN       

    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

    CALL ods.usp_etlerrorinsert('DWH','f_waveheader','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;
ALTER PROCEDURE click.usp_f_waveheader()
    OWNER TO proconnect;
