CREATE PROCEDURE dwh.usp_f_purchasereqheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_prq_preqm_pur_reqst_hdr;

	UPDATE dwh.f_purchasereqheader t
    SET 
          preqm_hr_curr_key             = COALESCE(c.curr_key,-1)
        , preqm_prtype                  = s.preqm_prtype
		, preqm_prmode                  = s.preqm_prmode
		, preqm_folder                  = s.preqm_folder
		, preqm_orgsource               = s.preqm_orgsource
		, preqm_prdate                  = s.preqm_prdate
		, preqm_authdate                = s.preqm_authdate
		, preqm_status                  = s.preqm_status
		, preqm_ou_po                   = s.preqm_ou_po
		, preqm_ou_gr                   = s.preqm_ou_gr
		, preqm_currency                = s.preqm_currency
		, preqm_prvalue                 = s.preqm_prvalue
		, preqm_remarks                 = s.preqm_remarks
		, preqm_reasoncode              = s.preqm_reasoncode
		, preqm_requesterid             = s.preqm_requesterid
		, preqm_hold                    = s.preqm_hold
		, preqm_createdby               = s.preqm_createdby
		, preqm_createddate             = s.preqm_createddate
		, preqm_lastmodifiedby          = s.preqm_lastmodifiedby
		, preqm_lastmodifieddate        = s.preqm_lastmodifieddate
		, preqm_timestamp_value         = s.preqm_timestamp_value
		, preqm_req_name                = s.preqm_req_name
		, preqm_exchange_rate           = s.preqm_exchange_rate
		, preqm_num_series              = s.preqm_num_series
		, preqm_mobile_flag             = s.preqm_mobile_flag
		, preqm_auth_remarks            = s.preqm_auth_remarks
		, preqm_adhocplng               = s.preqm_adhocplng
		, preqm_requested_For           = s.preqm_requested_For
		, etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_prq_preqm_pur_reqst_hdr s
	LEFT JOIN dwh.d_currency c 		
		ON  s.preqm_currency            = c.iso_curr_code 
    WHERE   t.preqm_prou 				= s.preqm_prou
		AND t.preqm_prno 				= s.preqm_prno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_purchasereqheader
	(
		  	preqm_hr_curr_key,
        preqm_prou				, preqm_prno				, preqm_prtype			, preqm_prmode			, preqm_folder
		, preqm_orgsource			, preqm_prdate				, preqm_authdate		, preqm_status			, preqm_ou_po
		, preqm_ou_gr				, preqm_currency			, preqm_prvalue			, preqm_remarks			, preqm_reasoncode
		, preqm_requesterid			, preqm_hold				, preqm_createdby		, preqm_createddate		, preqm_lastmodifiedby
		, preqm_lastmodifieddate	, preqm_timestamp_value		, preqm_req_name		, preqm_exchange_rate	, preqm_num_series
		, preqm_mobile_flag			, preqm_auth_remarks		, preqm_adhocplng		, preqm_requested_For
        , etlactiveind				, etljobname                , envsourcecd			, datasourcecd			, etlcreatedatetime
	)
	
	SELECT 
	   	COALESCE(c.curr_key,-1),
        s.preqm_prou				, s.preqm_prno				, s.preqm_prtype		, s.preqm_prmode			, s.preqm_folder
		, s.preqm_orgsource			, s.preqm_prdate			, s.preqm_authdate		, s.preqm_status			, s.preqm_ou_po
		, s.preqm_ou_gr				, s.preqm_currency			, s.preqm_prvalue		, s.preqm_remarks			, s.preqm_reasoncode
		, s.preqm_requesterid		, s.preqm_hold				, s.preqm_createdby		, s.preqm_createddate		, s.preqm_lastmodifiedby
		, s.preqm_lastmodifieddate	, s.preqm_timestamp_value	, s.preqm_req_name		, s.preqm_exchange_rate		, s.preqm_num_series
		, s.preqm_mobile_flag		, s.preqm_auth_remarks		, s.preqm_adhocplng		, s.preqm_requested_For
        , 1 AS etlactiveind			, p_etljobname              , p_envsourcecd			, p_datasourcecd			, NOW()
	FROM stg.stg_prq_preqm_pur_reqst_hdr s
	LEFT JOIN dwh.d_currency c 		
		ON  s.preqm_currency            = c.iso_curr_code 
	LEFT JOIN dwh.f_purchasereqheader t 	
		ON  t.preqm_prou 				= s.preqm_prou
		AND t.preqm_prno 				= s.preqm_prno
    WHERE t.preqm_prou IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_prq_preqm_pur_reqst_hdr
	(
		preqm_prou, 			preqm_prno, 			preqm_prtype, 			preqm_prmode, 		preqm_folder, 
		preqm_orgsource, 		preqm_prdate, 			preqm_authdate, 		preqm_status, 		preqm_ou_po, 
		preqm_ou_gr, 			preqm_currency, 		preqm_prvalue, 			preqm_pcstatus, 	preqm_remarks, 
		preqm_reasoncode, 		preqm_requesterid, 		preqm_hold, 			preqm_createdby, 	preqm_createddate, 
		preqm_lastmodifiedby, 	preqm_lastmodifieddate, preqm_timestamp_value, 	preqm_req_name, 	wf_status, 
		preqm_exchange_rate, 	preqm_wf_docid, 		preqm_num_series, 		preqm_prjcode, 		preqm_prjou, 
		preqm_mobile_flag, 		preqm_auth_remarks, 	preqm_adhocplng, 		preqm_clientcode, 	preqm_budgetdescription, 
		preqm_requested_for, 	preqm_createdfrm, 		preqm_cls_code, 		preqm_scls_code, 	preqm_reason_return, 
		etlcreateddatetime
	
	)
	SELECT 
		preqm_prou, 			preqm_prno, 			preqm_prtype, 			preqm_prmode, 		preqm_folder, 
		preqm_orgsource, 		preqm_prdate, 			preqm_authdate, 		preqm_status, 		preqm_ou_po, 
		preqm_ou_gr, 			preqm_currency, 		preqm_prvalue, 			preqm_pcstatus, 	preqm_remarks, 
		preqm_reasoncode, 		preqm_requesterid, 		preqm_hold, 			preqm_createdby, 	preqm_createddate, 
		preqm_lastmodifiedby, 	preqm_lastmodifieddate, preqm_timestamp_value, 	preqm_req_name, 	wf_status, 
		preqm_exchange_rate, 	preqm_wf_docid, 		preqm_num_series, 		preqm_prjcode, 		preqm_prjou, 
		preqm_mobile_flag, 		preqm_auth_remarks, 	preqm_adhocplng, 		preqm_clientcode, 	preqm_budgetdescription, 
		preqm_requested_for, 	preqm_createdfrm, 		preqm_cls_code, 		preqm_scls_code, 	preqm_reason_return, 
		etlcreateddatetime
	FROM stg.stg_prq_preqm_pur_reqst_hdr;
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
$$;