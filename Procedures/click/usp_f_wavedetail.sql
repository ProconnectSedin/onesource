-- PROCEDURE: click.usp_f_wavedetail()

-- DROP PROCEDURE IF EXISTS click.usp_f_wavedetail();

CREATE OR REPLACE PROCEDURE click.usp_f_wavedetail(
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
	FROM CLICK.f_wavedetail;

	IF v_maxdate = '1900-01-01'

	THEN

	INSERT INTO click.f_wavedetail
	(
		wave_dtl_key		, wave_loc_key		, wave_item_key		, wave_cust_key, 
		wave_hdr_key		, wave_loc_code		, wave_no			, wave_ou, 
		wave_lineno			, wave_so_no		, wave_so_sr_no		, wave_so_sch_no, 
		wave_item_code		, wave_qty			, wave_line_status	, wave_outbound_no, 
		wave_customer_code	, 
		wave_customer_item_code	, 
		etlactiveind		, etljobname		, envsourcecd		, datasourcecd, 
		etlcreatedatetime	, etlupdatedatetime	, createddate
	)

	SELECT
		wd.wave_dtl_key			, wd.wave_loc_key		, wd.wave_item_key		, wd.wave_cust_key, 
		wd.wave_hdr_key			, wd.wave_loc_code		, wd.wave_no			, wd.wave_ou, 
		wd.wave_lineno			, wd.wave_so_no			, wd.wave_so_sr_no		, wd.wave_so_sch_no, 
		wd.wave_item_code		, wd.wave_qty			, wd.wave_line_status	, wd.wave_outbound_no, 
		wd.wave_customer_code	, 
		wd.wave_customer_item_code, 
		wd.etlactiveind			, wd.etljobname			, wd.envsourcecd		, wd.datasourcecd, 
		wd.etlcreatedatetime	, wd.etlupdatedatetime	, NOW()		
	FROM dwh.f_wavedetail wd;

	ELSE

	UPDATE click.f_wavedetail CWD
	SET
		wave_dtl_key			= wd.wave_dtl_key,
		wave_loc_key			= wd.wave_loc_key,
		wave_item_key			= wd.wave_item_key,
		wave_cust_key			= wd.wave_cust_key,
		wave_hdr_key			= wd.wave_hdr_key,
		wave_loc_code			= wd.wave_loc_code,
		wave_no					= wd.wave_no,
		wave_ou					= wd.wave_ou,
		wave_lineno				= wd.wave_lineno,
		wave_so_no				= wd.wave_so_no,
		wave_so_sr_no			= wd.wave_so_sr_no,
		wave_so_sch_no			= wd.wave_so_sch_no,
		wave_item_code			= wd.wave_item_code,
		wave_qty				= wd.wave_qty,
		wave_line_status		= wd.wave_line_status,
		wave_outbound_no		= wd.wave_outbound_no,
		wave_customer_code		= wd.wave_customer_code,
		wave_customer_item_code	= wd.wave_customer_item_code,
		etlactiveind			= wd.etlactiveind,
		etljobname				= wd.etljobname,
		envsourcecd				= wd.envsourcecd,
		datasourcecd			= wd.datasourcecd,
		etlcreatedatetime		= wd.etlcreatedatetime,
		etlupdatedatetime		= wd.etlupdatedatetime,
		updatedatetime			= NOW()
	FROM dwh.f_wavedetail wd
	WHERE CWD.wave_dtl_key		= wd.wave_dtl_key
	AND COALESCE(wd.etlupdatedatetime,wd.etlcreatedatetime) >= v_maxdate;	
	
	INSERT INTO click.f_wavedetail
	(
		wave_dtl_key		, wave_loc_key		, wave_item_key		, wave_cust_key, 
		wave_hdr_key		, wave_loc_code		, wave_no			, wave_ou, 
		wave_lineno			, wave_so_no		, wave_so_sr_no		, wave_so_sch_no, 
		wave_item_code		, wave_qty			, wave_line_status	, wave_outbound_no, 
		wave_customer_code	, 
		wave_customer_item_code	, 
		etlactiveind		, etljobname		, envsourcecd		, datasourcecd, 
		etlcreatedatetime	, etlupdatedatetime	, createddate
	)

	SELECT
		wd.wave_dtl_key			, wd.wave_loc_key		, wd.wave_item_key		, wd.wave_cust_key, 
		wd.wave_hdr_key			, wd.wave_loc_code		, wd.wave_no			, wd.wave_ou, 
		wd.wave_lineno			, wd.wave_so_no			, wd.wave_so_sr_no		, wd.wave_so_sch_no, 
		wd.wave_item_code		, wd.wave_qty			, wd.wave_line_status	, wd.wave_outbound_no, 
		wd.wave_customer_code	, 
		wd.wave_customer_item_code, 
		wd.etlactiveind			, wd.etljobname			, wd.envsourcecd		, wd.datasourcecd, 
		wd.etlcreatedatetime	, wd.etlupdatedatetime	, NOW()
	FROM dwh.f_wavedetail wd
	LEFT JOIN click.f_wavedetail CWD
	ON CWD.wave_dtl_key	= wd.wave_dtl_key
	WHERE  COALESCE(wd.etlupdatedatetime,wd.etlcreatedatetime) >= v_maxdate
	AND CWD.wave_dtl_key IS NULL;
	
	END IF;

	EXCEPTION WHEN others THEN       

    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

    CALL ods.usp_etlerrorinsert('DWH','f_wavedetail','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;
ALTER PROCEDURE click.usp_f_wavedetail()
    OWNER TO proconnect;
