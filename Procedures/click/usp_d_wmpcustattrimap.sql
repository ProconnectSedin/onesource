CREATE OR REPLACE PROCEDURE click.usp_d_wmpcustattrimap(
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
	FROM CLICK.d_wmpcustattrimap;

	IF v_maxdate = '1900-01-01'

	THEN

	INSERT into click.d_wmpcustattrimap
	(
		custattrimap_key	, effective_from	, effective_to	, customer_id, 
		customer_name		, attribute_code	, attribute_name, attribute_prcnt, 
		etlactiveind		, etljobname		, envsourcecd	, datasourcecd, 
		etlcreatedatetime	, etlupdatedatetime	, createddate
	)
	select
		d.custattrimap_key	, d.effective_from		, d.effective_to	, d.customer_id, 
		d.customer_name		, d.attribute_code		, d.attribute_name	, d.attribute_prcnt, 
		d.etlactiveind		, d.etljobname			, d.envsourcecd		, d.datasourcecd, 
		d.etlcreatedatetime	, d.etlupdatedatetime	, NOW()
	FROM dwh.d_wmpcustattrimap d;

	ELSE

	update click.d_wmpcustattrimap c
	set
		custattrimap_key	= d.custattrimap_key,
		effective_from		= d.effective_from,
		effective_to		= d.effective_to,
		customer_id			= d.customer_id,
		customer_name		= d.customer_name,
		attribute_code		= d.attribute_code,
		attribute_name		= d.attribute_name,
		attribute_prcnt		= d.attribute_prcnt,
		etlactiveind		= d.etlactiveind,
		etljobname			= d.etljobname,
		envsourcecd			= d.envsourcecd,
		datasourcecd		= d.datasourcecd,
		etlcreatedatetime	= d.etlcreatedatetime,
		etlupdatedatetime	= d.etlupdatedatetime,
		updatedatetime		= NOW()
	FROM dwh.d_wmpcustattrimap d
	WHERE c.custattrimap_key	= d.custattrimap_key
	AND COALESCE(d.etlupdatedatetime,d.etlcreatedatetime) >= v_maxdate;
	
	INSERT into click.d_wmpcustattrimap
	(
		custattrimap_key	, effective_from	, effective_to	, customer_id, 
		customer_name		, attribute_code	, attribute_name, attribute_prcnt, 
		etlactiveind		, etljobname		, envsourcecd	, datasourcecd, 
		etlcreatedatetime	, etlupdatedatetime	, createddate	, updatedatetime
	)
	
	select
		d.custattrimap_key	, d.effective_from		, d.effective_to	, d.customer_id, 
		d.customer_name		, d.attribute_code		, d.attribute_name	, d.attribute_prcnt, 
		d.etlactiveind		, d.etljobname			, d.envsourcecd		, d.datasourcecd, 
		d.etlcreatedatetime	, d.etlupdatedatetime	, NOW()
	FROM dwh.d_wmpcustattrimap d
	LEFT JOIN click.d_wmpcustattrimap c
	on c.custattrimap_key	= d.custattrimap_key
	where COALESCE(w.etlupdatedatetime,w.etlcreatedatetime) >= v_maxdate
	and c.custattrimap_key is null;
	
	END IF;

	EXCEPTION WHEN others THEN       

    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

    CALL ods.usp_etlerrorinsert('DWH','d_wmpcustattrimap','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;