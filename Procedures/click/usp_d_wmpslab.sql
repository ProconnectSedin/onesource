CREATE OR REPLACE PROCEDURE click.usp_d_wmpslab(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	v_maxdate date;
BEGIN

	TRUNCATE TABLE click.d_wmpslab
	RESTART IDENTITY;

	INSERT INTO click.d_wmpslab
	(
		wmpslab_key		, effective_from	, effective_to, 
		category		, subcategory		, slab_prcnt_from, 
		slab_prcnt_to	, score		, 
		etlactiveind	, etljobname		, envsourcecd,
		datasourcecd	, etlcreatedatetime	, etlupdatedatetime, 
		createddate
	)

	SELECT
		d.wmpslab_key		, d.effective_from		, d.effective_to, 
		d.category			, d.subcategory			, d.slab_prcnt_from, 
		d.slab_prcnt_to		, d.score			,
		d.etlactiveind		, d.etljobname			, d.envsourcecd,
		d.datasourcecd		, d.etlcreatedatetime	, d.etlupdatedatetime, 
		NOW()
	FROM dwh.d_wmpslab d;

	EXCEPTION WHEN others THEN       

    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

    CALL ods.usp_etlerrorinsert('DWH','d_wmpslab','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;