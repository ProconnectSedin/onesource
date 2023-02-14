CREATE OR REPLACE PROCEDURE click.usp_d_wmpcategory(
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
	FROM CLICK.d_wmpcategory;

	IF v_maxdate = '1900-01-01'

	THEN
	INSERT INTO click.d_wmpcategory
	(
		category_key			, category_code		, category_desc,
		subcategory_code		, subcategory_desc	, target_prcnt,
		final_weightage_prcnt	, effective_from	, effective_to,
		etlactiveind			, etljobname		, envsourcecd,
		datasourcecd			, etlcreatedatetime	, etlupdatedatetime,
		createddate
	)
	SELECT
		wmp.category_key			, wmp.category_code		, wmp.category_desc,
		wmp.subcategory_code		, wmp.subcategory_desc	, wmp.target_prcnt,
		wmp.final_weightage_prcnt	, wmp.effective_from	, wmp.effective_to,
		wmp.etlactiveind			, wmp.etljobname		, wmp.envsourcecd,
		wmp.datasourcecd			, wmp.etlcreatedatetime	, wmp.etlupdatedatetime,
		NOW()
	FROM dwh.d_wmpcategory wmp;
	
	ELSE

	UPDATE click.d_wmpcategory t
	SET
		category_key			= wmp.category_key,
		category_code			= wmp.category_code,
		category_desc			= wmp.category_desc,
		subcategory_code		= wmp.subcategory_code,
		subcategory_desc		= wmp.subcategory_desc,
		target_prcnt			= wmp.target_prcnt,
		final_weightage_prcnt	= wmp.final_weightage_prcnt,
		effective_from			= wmp.effective_from,
		effective_to			= wmp.effective_to,
		etlactiveind			= wmp.etlactiveind,
		etljobname				= wmp.etljobname,
		envsourcecd				= wmp.envsourcecd,
		datasourcecd			= wmp.datasourcecd,
		etlcreatedatetime		= wmp.etlcreatedatetime,
		etlupdatedatetime		= wmp.etlupdatedatetime,
		updatedatetime			= NOW()
	FROM dwh.d_wmpcategory wmp
	WHERE t.category_key		= wmp.category_key
	AND COALESCE(wmp.etlupdatedatetime,wmp.etlcreatedatetime) >= v_maxdate;

	INSERT INTO click.d_wmpcategory
	(
		category_key			, category_code		, category_desc,
		subcategory_code		, subcategory_desc	, target_prcnt,
		final_weightage_prcnt	, effective_from	, effective_to,
		etlactiveind			, etljobname		, envsourcecd,
		datasourcecd			, etlcreatedatetime	, etlupdatedatetime,
		createddate
	)
	SELECT
		wmp.category_key			, wmp.category_code		, wmp.category_desc,
		wmp.subcategory_code		, wmp.subcategory_desc	, wmp.target_prcnt,
		wmp.final_weightage_prcnt	, wmp.effective_from	, wmp.effective_to,
		wmp.etlactiveind			, wmp.etljobname		, wmp.envsourcecd,
		wmp.datasourcecd			, wmp.etlcreatedatetime	, wmp.etlupdatedatetime,
		NOW()
	FROM dwh.d_wmpcategory wmp
	LEFT JOIN click.d_wmpcategory t
	ON 	t.category_key		= wmp.category_key
	WHERE  COALESCE(wmp.etlupdatedatetime,wmp.etlcreatedatetime) >= v_maxdate
	and t.category_code is null;

	END IF;

	EXCEPTION WHEN others THEN       

    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

    CALL ods.usp_etlerrorinsert('DWH','d_wmpcategory','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;