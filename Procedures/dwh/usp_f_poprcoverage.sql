CREATE PROCEDURE dwh.usp_f_poprcoverage(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE 
	p_etljobname VARCHAR(100);
	p_envsourcecd VARCHAR(50);
	p_datasourcecd VARCHAR(50);
    p_batchid INTEGER;
	p_taskname VARCHAR(100);
	p_packagename  VARCHAR(100);
    p_errorid INTEGER;
	p_errordesc character varying;
	p_errorline INTEGER;	
    p_rawstorageflag integer;

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt FROM stg.stg_po_poprq_poprcovg_detail;

	UPDATE dwh.f_poprcoverage t
    SET 
		 
		  poprq_pocovqty                = s.poprq_pocovqty
        , poprq_createdby               = s.poprq_createdby
        , poprq_createddate             = s.poprq_createddate
        , poprq_lastmodifiedby          = s.poprq_lastmodifiedby
        , poprq_grrecvdqty              = s.poprq_grrecvdqty
        , poprq_lastmodifieddate        = s.poprq_lastmodifieddate
		, etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_po_poprq_poprcovg_detail s  	
    WHERE   	t.poprq_poou            = s.poprq_poou
            AND t.poprq_pono            = s.poprq_pono
            AND t.poprq_poamendmentno   = s.poprq_poamendmentno
            AND t.poprq_polineno        = s.poprq_polineno
            AND t.poprq_scheduleno      = s.poprq_scheduleno
            AND t.poprq_prno            = s.poprq_prno
            AND t.poprq_posubscheduleno = s.poprq_posubscheduleno
            AND t.poprq_prlineno        = s.poprq_prlineno
            AND t.poprq_prou            = s.poprq_prou
            AND t.poprq_pr_shdno        = s.poprq_pr_shdno
            AND t.poprq_pr_subsceduleno = s.poprq_pr_subsceduleno;
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_poprcoverage
	(
				
          poprq_poou			, poprq_pono				, poprq_poamendmentno	 	, poprq_polineno		, poprq_scheduleno
        , poprq_prno			, poprq_posubscheduleno		, poprq_prlineno		 	, poprq_prou			, poprq_pr_shdno
        , poprq_pocovqty		, poprq_createdby			, poprq_pr_subsceduleno	 	, poprq_createddate		, poprq_lastmodifiedby
        , poprq_grrecvdqty		, poprq_lastmodifieddate
        , etlactiveind			, etljobname                , envsourcecd				, datasourcecd			, etlcreatedatetime
	)
	
	SELECT DISTINCT 
		
          s.poprq_poou			, s.poprq_pono				, s.poprq_poamendmentno	 	, s.poprq_polineno		, s.poprq_scheduleno
        , s.poprq_prno			, s.poprq_posubscheduleno	, s.poprq_prlineno		 	, s.poprq_prou			, s.poprq_pr_shdno
        , s.poprq_pocovqty		, s.poprq_createdby			, s.poprq_pr_subsceduleno	, s.poprq_createddate	, s.poprq_lastmodifiedby
        , s.poprq_grrecvdqty	, s.poprq_lastmodifieddate
        , 1 AS etlactiveind		    , p_etljobname                  , p_envsourcecd					, p_datasourcecd			, NOW()
	FROM stg.stg_po_poprq_poprcovg_detail s
	LEFT JOIN dwh.f_poprcoverage t  	
		    ON  t.poprq_poou            = s.poprq_poou
            AND t.poprq_pono            = s.poprq_pono
            AND t.poprq_poamendmentno   = s.poprq_poamendmentno
            AND t.poprq_polineno        = s.poprq_polineno
            AND t.poprq_scheduleno      = s.poprq_scheduleno
            AND t.poprq_prno            = s.poprq_prno
            AND t.poprq_posubscheduleno = s.poprq_posubscheduleno
            AND t.poprq_prlineno        = s.poprq_prlineno
            AND t.poprq_prou            = s.poprq_prou
            AND t.poprq_pr_shdno        = s.poprq_pr_shdno
            AND t.poprq_pr_subsceduleno = s.poprq_pr_subsceduleno
    WHERE t.poprq_poou IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_po_poprq_poprcovg_detail
	(
		poprq_poou, 		poprq_pono, 				poprq_poamendmentno, 		poprq_polineno, 		poprq_scheduleno, 
		poprq_prno, 		poprq_posubscheduleno, 		poprq_prlineno, 			poprq_prou, 			poprq_pr_shdno, 
		poprq_pocovqty, 	poprq_createdby, 			poprq_pr_subsceduleno, 		poprq_createddate, 		poprq_lastmodifiedby, 
		poprq_grrecvdqty, 	poprq_lastmodifieddate, 	etlcreateddatetime
	)
	SELECT 
		poprq_poou, 		poprq_pono, 				poprq_poamendmentno, 		poprq_polineno, 		poprq_scheduleno, 
		poprq_prno, 		poprq_posubscheduleno, 		poprq_prlineno, 			poprq_prou, 			poprq_pr_shdno, 
		poprq_pocovqty, 	poprq_createdby, 			poprq_pr_subsceduleno, 		poprq_createddate, 		poprq_lastmodifiedby, 
		poprq_grrecvdqty, 	poprq_lastmodifieddate, 	etlcreateddatetime
	FROM stg.stg_po_poprq_poprcovg_detail;
    END IF;	
	
    EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate,p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
        
    SELECT 0 INTO inscnt;
    SELECT 0 INTO updcnt; 	
END;
$$;