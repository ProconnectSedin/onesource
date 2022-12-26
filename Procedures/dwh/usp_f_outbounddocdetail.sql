-- PROCEDURE: dwh.usp_f_outbounddocdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_outbounddocdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_outbounddocdetail(
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
	p_depsource VARCHAR(100);
    
    p_rawstorageflag integer;

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag ,h.depsource
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;
		
IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
                    AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
    THEN	

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_outbound_doc_detail;

	UPDATE dwh.f_outboundDocDetail t
    SET 
	
	obh_hr_key  				=    ob.obh_hr_key,
    obd_loc_key                 = COALESCE(l.loc_key,-1),
    oub_doc_loc_code       		= s.wms_oub_doc_loc_code,
		oub_outbound_ord       	= s.wms_oub_outbound_ord,
		oub_doc_lineno       	= s.wms_oub_doc_lineno,
		oub_doc_ou       		= s.wms_oub_doc_ou,
		oub_doc_type       		= s.wms_oub_doc_type,
		oub_doc_attach       	= s.wms_oub_doc_attach,
		oub_doc_hdn_attach      = s.wms_oub_doc_hdn_attach,
		etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_outbound_doc_detail s
	INNER JOIN dwh.f_outboundheader ob
	on  s.wms_oub_doc_ou = ob.oub_ou
	and s.wms_oub_doc_loc_code = ob.oub_loc_code 
	and s.wms_oub_outbound_ord =ob.oub_outbound_ord
	
		LEFT JOIN dwh.d_location L 		
		ON s.wms_oub_doc_loc_code 	= L.loc_code 
        AND s.wms_oub_doc_ou      = L.loc_ou

  

    WHERE   t.oub_doc_loc_code       	= s.wms_oub_doc_loc_code
					AND	t.oub_outbound_ord       	= s.wms_oub_outbound_ord
					AND	t.oub_doc_lineno        	= s.wms_oub_doc_lineno
						AND t.oub_doc_ou          		= s.wms_oub_doc_ou
						AND t.obh_hr_key  =    ob.obh_hr_key;
 
/*
   
   		DELETE FROM dwh.f_outboundDocDetail FH
		USING stg.stg_wms_outbound_doc_detail OH
		WHERE FH.oub_doc_loc_code       = OH.wms_oub_doc_loc_code
		AND	FH.oub_outbound_ord       	= OH.wms_oub_outbound_ord
		AND	FH.oub_doc_lineno        	= OH.wms_oub_doc_lineno
		AND FH.oub_doc_ou          		= OH.wms_oub_doc_ou;
-- 		AND COALESCE(ob.oub_modified_date,ob.oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
*/
 
    GET DIAGNOSTICS updcnt = ROW_COUNT;
--	select 0 into updcnt;

	INSERT INTO dwh.f_outboundDocDetail
	(    obh_hr_key,obd_loc_key,
					oub_doc_loc_code,
          oub_outbound_ord,
          oub_doc_lineno,
          oub_doc_ou,
          oub_doc_type,
          oub_doc_attach,
          oub_doc_hdn_attach,
       etlactiveind,			     etljobname
		, envsourcecd,                     datasourcecd,                 etlcreatedatetime
	)
	
	SELECT 

      ob.obh_hr_key,COALESCE(l.loc_key,-1),OH.wms_oub_doc_loc_code,
      OH.wms_oub_outbound_ord,
      OH.wms_oub_doc_lineno,
      OH.wms_oub_doc_ou,
      OH.wms_oub_doc_type,
      OH.wms_oub_doc_attach,
      OH.wms_oub_doc_hdn_attach,          1 AS etlactiveind,				       p_etljobname,
		p_envsourcecd							, p_datasourcecd,                      NOW()
      
	FROM stg.stg_wms_outbound_doc_detail OH
	INNER JOIN dwh.f_outboundheader ob
		on  OH.wms_oub_doc_ou = ob.oub_ou
		and OH.wms_oub_doc_loc_code = ob.oub_loc_code 
		and OH.wms_oub_outbound_ord =ob.oub_outbound_ord
	LEFT JOIN dwh.d_location L 		
		ON OH.wms_oub_doc_loc_code 	= L.loc_code 
        AND OH.wms_oub_doc_ou      = L.loc_ou

	LEFT JOIN dwh.f_outboundDocDetail FH 	
		ON FH.oub_doc_loc_code       	= OH.wms_oub_doc_loc_code
		AND	FH.oub_outbound_ord       	= OH.wms_oub_outbound_ord
		AND	FH.oub_doc_lineno        	= OH.wms_oub_doc_lineno
		AND FH.oub_doc_ou          		= OH.wms_oub_doc_ou
        AND FH.obh_hr_key 				=    ob.obh_hr_key
	    WHERE FH.oub_doc_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
/*	
	UPDATE dwh.f_outboundDocDetail s
    SET obh_hr_key  			   =    ob.obh_hr_key,
		etlupdatedatetime          =    NOW()
	FROM dwh.f_outboundheader ob
	where   s.oub_doc_ou 		= 	ob.oub_ou
	and 	s.oub_doc_loc_code 	= 	ob.oub_loc_code 
	and 	s.oub_outbound_ord 	=	ob.oub_outbound_ord
	and COALESCE(ob.oub_modified_date,ob.oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
*/	
	
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_outbound_doc_detail

	(
	    wms_oub_doc_loc_code,	wms_oub_outbound_ord,		wms_oub_doc_lineno,
		wms_oub_doc_ou,			wms_oub_doc_type,			wms_oub_doc_attach,
		wms_oub_doc_hdn_attach,	etlcreateddatetime
	)
	SELECT 
		wms_oub_doc_loc_code,	wms_oub_outbound_ord,		wms_oub_doc_lineno,
		wms_oub_doc_ou,			wms_oub_doc_type,			wms_oub_doc_attach,
		wms_oub_doc_hdn_attach, etlcreateddatetime
	FROM stg.stg_wms_outbound_doc_detail;
    END IF;
ELSE    
         p_errorid   := 0;
         select 0 into inscnt;
            select 0 into updcnt;
         select 0 into srccnt;    
         
         IF p_depsource IS NULL
         THEN 
         p_errordesc := 'The Dependent source cannot be NULL.';
         ELSE
         p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source '|| p_sourceid||'.';
         END IF;
         CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
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
ALTER PROCEDURE dwh.usp_f_outbounddocdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
