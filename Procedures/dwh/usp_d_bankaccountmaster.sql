CREATE PROCEDURE dwh.usp_d_bankaccountmaster(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_bnkdef_acc_mst;

	UPDATE dwh.d_bankaccountmaster t
    SET 
		btimestamp 				= s.btimestamp,
		flag 					= s.flag,
		currency_code 			= s.currency_code,
		credit_limit 			= s.credit_limit,
		draw_limit 				= s.draw_limit,
		status 					= s.status,
		effective_from 			= s.effective_from,
		creation_ou 			= s.creation_ou,
		createdby 				= s.createdby,
		createddate 			= s.createddate,
		acctrf 					= s.acctrf,
		neft 					= s.neft,
		rtgs 					= s.rtgs,
		restpostingaftrrecon 	= s.restpostingaftrrecon,
		echeq 					= s.echeq,
		etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_bnkdef_acc_mst s
    WHERE t.company_code  		= s.company_code
	AND t.bank_ref_no 			= s.bank_ref_no
	AND t.bank_acc_no 			= s.bank_acc_no
	AND t.serial_no 			= s.serial_no;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_bankaccountmaster
	(
		company_code,		bank_ref_no,	bank_acc_no,			serial_no,			btimestamp,
		flag,				currency_code,	credit_limit,			draw_limit,			status,
		effective_from,		creation_ou,	createdby,				createddate,		acctrf,
		neft,				rtgs,			restpostingaftrrecon,	echeq,				etlactiveind,
        etljobname, 		envsourcecd, 	datasourcecd, 			etlcreatedatetime
	)
	
    SELECT 
		s.company_code,		s.bank_ref_no,		s.bank_acc_no,			s.serial_no,		s.btimestamp,
		s.flag,				s.currency_code,	s.credit_limit,			s.draw_limit,		s.status,
		s.effective_from,	s.creation_ou,		s.createdby,			s.createddate,		s.acctrf,
		s.neft,				s.rtgs,				s.restpostingaftrrecon,	s.echeq,			1,
		p_etljobname,		p_envsourcecd,		p_datasourcecd,			NOW()
	FROM stg.stg_bnkdef_acc_mst s
    LEFT JOIN dwh.d_bankaccountmaster t
    ON 	s.company_code  		= t.company_code
	AND s.bank_ref_no 			= t.bank_ref_no
	AND s.bank_acc_no 			= t.bank_acc_no
	AND s.serial_no 			= t.serial_no 
    WHERE t.company_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	IF p_rawstorageflag = 1
	THEN
	
	INSERT INTO raw.raw_bnkdef_acc_mst
	(
		company_code, bank_ref_no, bank_acc_no, serial_no, btimestamp,
        flag, currency_code, credit_limit, draw_limit, status, 
        effective_from, effective_to, creation_ou, modification_ou, createdby,
        createddate, modifiedby, modifieddate, iban, bsrno,
        micrcode, acctrf, neft, rtgs, 
        restpostingaftrrecon, echeq, etlcreateddatetime
	
	)
	SELECT 
		 company_code, bank_ref_no, bank_acc_no, serial_no, btimestamp,
        flag, currency_code, credit_limit, draw_limit, status, 
        effective_from, effective_to, creation_ou, modification_ou, createdby,
        createddate, modifiedby, modifieddate, iban, bsrno,
        micrcode, acctrf, neft, rtgs, 
        restpostingaftrrecon, echeq, etlcreateddatetime
	FROM stg.stg_bnkdef_acc_mst;
	
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