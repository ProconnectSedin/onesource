CREATE PROCEDURE dwh.usp_d_bankrefmaster(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename,h.rawstorageflag
 
	INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname,p_rawstorageflag
 
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_emod_bank_ref_mst;

	UPDATE dwh.d_bankrefmaster t
    SET 
		btimestamp       = s.btimestamp       ,
		bank_ptt_flag    = s.bank_ptt_flag   ,
		bank_type        = s.bank_type       ,
		bank_name        = s.bank_name       ,
		address1         = s.address1        ,
		address2         = s.address2        ,
		address3         = s.address3        ,
		city             = s.city            ,
		state            = s.state           ,
		country          = s.country         ,
		clearing_no      = s.clearing_no     ,
		swift_no         = s.swift_no        ,
		zip_code         = s.zip_code        ,
		creation_ou      = s.creation_ou     ,
		modification_ou  = s.modification_ou ,
		effective_from   = s.effective_from  ,
		createdby        = s.createdby       ,
		createddate      = s.createddate     ,
		modifiedby       = s.modifiedby      ,
		modifieddate     = s.modifieddate    ,
		createdin        = s.createdin       ,
		ifsccode         = s.ifsccode        ,
		long_description = s.long_description,
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_emod_bank_ref_mst s
    WHERE t.bank_ref_no  		= s.bank_ref_no
	AND t.bank_status 			= s.bank_status;
	
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_bankrefmaster
	(
		bank_ref_no,         bank_status,         btimestamp,          bank_ptt_flag,           bank_type,
        bank_name,           address1,            address2,            address3,                city,
        state,               country,             clearing_no,         swift_no,                zip_code,
        creation_ou,         modification_ou,     effective_from,      createdby,               createddate,
        modifiedby,          modifieddate,        createdin,           ifsccode,                long_description,
		etlactiveind,        etljobname, 		  envsourcecd, 	       datasourcecd, 			etlcreatedatetime
	)
	
    SELECT 
        s.bank_ref_no,         s.bank_status,         s.btimestamp,          s.bank_ptt_flag,           s.bank_type,
        s.bank_name,           s.address1,            s.address2,            s.address3,                s.city,
        s.state,               s.country,             s.clearing_no,         s.swift_no,                s.zip_code,
        s.creation_ou,         s.modification_ou,     s.effective_from,      s.createdby,               s.createddate,
        s.modifiedby,          s.modifieddate,        s.createdin,           s.ifsccode,                s.long_description,
        1,                     p_etljobname,		  p_envsourcecd,	     p_datasourcecd,			NOW()
	FROM stg.stg_emod_bank_ref_mst s
    LEFT JOIN dwh.d_bankrefmaster t
    ON 	t.bank_ref_no  		= s.bank_ref_no
	AND t.bank_status 		= s.bank_status 
    WHERE t.bank_ref_no IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN
	
	INSERT INTO raw.raw_emod_bank_ref_mst
	(
	    bank_ref_no, bank_status, btimestamp, bank_ptt_flag, bank_type,
        bank_name, address1, address2, address3, city, 
        state, country, clearing_no, swift_no, phone_no, 
        telex, mail_stop, zip_code, fax, email_id, 
        creation_ou, modification_ou, effective_from, effective_to, createdby,
        createddate, modifiedby, modifieddate, bsrno, createdin,
        escrowaccount, ifsccode, long_description,etlcreateddatetime		
	)
	SELECT 
		bank_ref_no, bank_status, btimestamp, bank_ptt_flag, bank_type,
        bank_name, address1, address2, address3, city, 
        state, country, clearing_no, swift_no, phone_no, 
        telex, mail_stop, zip_code, fax, email_id, 
        creation_ou, modification_ou, effective_from, effective_to, createdby,
        createddate, modifiedby, modifieddate, bsrno, createdin,
        escrowaccount, ifsccode, long_description,etlcreateddatetime	
	FROM stg.stg_emod_bank_ref_mst;
	
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