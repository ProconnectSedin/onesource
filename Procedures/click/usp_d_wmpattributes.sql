CREATE OR REPLACE PROCEDURE click.usp_d_wmpattributes(
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
	FROM CLICK.d_wmpattributes;

	IF v_maxdate = '1900-01-01'

	THEN

	INSERT INTO click.d_wmpattributes
	(
		attributes_key		, category_code		, subcategory_code, 
		attribute_code		, attribute_name	, etlactiveind, 
		etljobname			, envsourcecd		, datasourcecd, 
		etlcreatedatetime	, etlupdatedatetime	, createddate
	)
	SELECT
		w.attributes_key		, w.category_code		, w.subcategory_code, 
		w.attribute_code		, w.attribute_name		, w.etlactiveind, 
		w.etljobname			, w.envsourcecd			, w.datasourcecd, 
		w.etlcreatedatetime		, w.etlupdatedatetime	, NOW()
	FROM dwh.d_wmpattributes w;
	
	ELSE

	UPDATE click.d_wmpattributes t
	SET
		attributes_key		= w.attributes_key,
		category_code		= w.category_code,
		subcategory_code	= w.subcategory_code,
		attribute_code		= w.attribute_code,
		attribute_name		= w.attribute_name,
		etlactiveind		= w.etlactiveind,
		etljobname			= w.etljobname,
		envsourcecd			= w.envsourcecd,
		datasourcecd		= w.datasourcecd,
		etlcreatedatetime	= w.etlcreatedatetime,
		etlupdatedatetime	= w.etlupdatedatetime,
		updatedatetime		= NOW()
	FROM dwh.d_wmpattributes w
	WHERE t.attributes_key		= w.attributes_key
	AND COALESCE(w.etlupdatedatetime,w.etlcreatedatetime) >= v_maxdate;
	
	INSERT INTO click.d_wmpattributes
	(
		attributes_key		, category_code		, subcategory_code, 
		attribute_code		, attribute_name	, etlactiveind, 
		etljobname			, envsourcecd		, datasourcecd, 
		etlcreatedatetime	, etlupdatedatetime	, createddate
	)
	SELECT
		w.attributes_key		, w.category_code		, w.subcategory_code, 
		w.attribute_code		, w.attribute_name		, w.etlactiveind, 
		w.etljobname			, w.envsourcecd			, w.datasourcecd, 
		w.etlcreatedatetime		, w.etlupdatedatetime	, NOW()
	FROM dwh.d_wmpattributes w
	LEFT JOIN click.d_wmpattributes t
	ON t.attributes_key		= w.attributes_key
	WHERE COALESCE(w.etlupdatedatetime,w.etlcreatedatetime) >= v_maxdate
	AND t.attributes_key IS NULL;

	END IF;

	EXCEPTION WHEN others THEN       

    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

    CALL ods.usp_etlerrorinsert('DWH','d_wmpattributes','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;