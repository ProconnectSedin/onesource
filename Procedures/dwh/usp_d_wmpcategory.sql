-- PROCEDURE: dwh.usp_d_wmpcategory(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_wmpcategory(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_wmpcategory(
	IN p_sourceid character varying,
	IN p_dataflowflag character varying,
	IN p_targetobject character varying,
	OUT srccnt integer,
	OUT inscnt integer,
	OUT updcnt integer,
	OUT dltcount integer,
	INOUT flag1 character varying,
	OUT flag2 character varying)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
	p_etljobname VARCHAR(100);
	p_envsourcecd VARCHAR(50);
	p_datasourcecd VARCHAR(50);
	p_batchid integer;
	p_taskname VARCHAR(100);
	p_packagename  VARCHAR(100);
    p_errorid integer;
	p_errordesc character varying;
	p_errorline integer;
	p_rawstorageflag integer;

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename,h.rawstorageflag
 
	INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname,p_rawstorageflag

	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid 		= h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wmpcategory;

	UPDATE dwh.d_wmpcategory w
	SET 
		category_desc			= s.category_desc,
		subcategory_desc		= s.subcategory_desc,
		target_prcnt			= (s.target_prcnt*100),
		final_weightage_prcnt	= (s.final_weightage_prcnt*100),
		effective_from			= s.effective_from,
		effective_to			= s.effective_to,
		etlactiveind			= 1,
		etljobname				= p_etljobname,
		envsourcecd				= p_envsourcecd,
		datasourcecd			= p_datasourcecd,
		etlupdatedatetime		= Now()
	FROM	stg.stg_wmpcategory s
	WHERE 	s.category_code		= w.category_code
	AND 	s.subcategory_code	= w.subcategory_code;
	
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_wmpcategory
	(
		category_code	, category_desc	, subcategory_code,
		subcategory_desc, target_prcnt	, final_weightage_prcnt,
		effective_from	, effective_to	,
		etlactiveind	, etljobname	, envsourcecd ,
		datasourcecd	, etlcreatedatetime	
	)
	
	SELECT
		s.category_code		, s.category_desc		, s.subcategory_code	,
		s.subcategory_desc	, (s.target_prcnt*100)	, (s.final_weightage_prcnt*100),
		s.effective_from	, s.effective_to		,
				1			, p_etljobname			, p_envsourcecd	,
		p_datasourcecd		, Now()		 
	FROM stg.stg_wmpcategory s
	LEFT JOIN dwh.d_wmpcategory w
	ON	s.category_code		= w.category_code
	AND	s.subcategory_code	= w.subcategory_code
	where w.category_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

	IF p_rawstorageflag = 1
	THEN
	
	INSERT INTO raw.raw_wmpcategory
	(
		category_code	, category_desc	, subcategory_code,
		subcategory_desc, target_prcnt	, final_weightage_prcnt,
		effective_from	, effective_to	, etlcreateddatetime	
	)
	
	SELECT
		category_code	, category_desc	, subcategory_code,
		subcategory_desc, target_prcnt	, final_weightage_prcnt,
		effective_from	, effective_to	, etlcreateddatetime
	FROM stg.stg_wmpcategory;
	END IF;
	
	EXCEPTION  
       WHEN others THEN       
       
      get stacked diagnostics
        p_errorid   = returned_sqlstate,
        p_errordesc = message_text;

    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,
                                p_batchid,p_taskname,'sp_ExceptionHandling',
                                p_errorid,p_errordesc,null);

       select 0 into inscnt;
       select 0 into updcnt;  

END;
$BODY$;
ALTER PROCEDURE dwh.usp_d_wmpcategory(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
