-- PROCEDURE: dwh.usp_d_wmpslab(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_wmpslab(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_wmpslab(
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
	FROM stg.stg_wmpslab;
	
		TRUNCATE TABLE dwh.d_wmpslab
		RESTART IDENTITY;
		
	GET DIAGNOSTICS updcnt = ROW_COUNT;	
	INSERT INTO DWH.d_wmpslab
	(
		effective_from,		effective_to,		category,		subcategory,
		slab_prcnt_from,	slab_prcnt_to,		score,				etlactiveind, 
		etljobname,			envsourcecd,		datasourcecd,		etlcreatedatetime
	)
	
	SELECT 
	
		effective_from,		effective_to,		category,		subcategory,
		slab_prcnt_from,	slab_prcnt_to,		score,			1,
		p_etljobname,		p_envsourcecd,		p_datasourcecd, now()
		
	from stg.stg_wmpslab;
	
	    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN	
	INSERT INTO raw.raw_wmpslab
	(
	effective_from,  effective_to,	category,	subcategory,
	slab_prcnt_from, slab_prcnt_to,	score,		etlcreateddatetime		
	)
	
	SELECT 
	 
	 effective_from,  effective_to,	category,	subcategory,
	slab_prcnt_from, slab_prcnt_to,	score,		etlcreateddatetime
	
	from stg.stg_wmpslab;
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
ALTER PROCEDURE dwh.usp_d_wmpslab(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
