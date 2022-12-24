CREATE or REPLACE PROCEDURE dwh.usp_d_company(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

-- DEPLOYMENT THROUGH GITHUB

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename,h.rawstorageflag
 
	INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname,p_rawstorageflag

	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_emod_company_mst;

	UPDATE dwh.d_Company t
    SET 
         ctimestamp         = s.ctimestamp,
         company_name       = s.company_name,
         address1           = s.address1,
         address2           = s.address2,
         address3           = s.address3,
         city               = s.city,
         country            = s.country,
         zip_code           = s.zip_code,
         phone_no           = s.phone_no,
         state              = s.state,
         company_url        = s.company_url,
         par_comp_code      = s.par_comp_code,
         base_currency      = s.base_currency,
         status             = s.status,
         effective_from     = s.effective_from,
         para_base_flag     = s.para_base_flag,
         reg_date           = s.reg_date,
         createdby          = s.createdby,
         createddate        = s.createddate,
         modifiedby         = s.modifiedby,
         modifieddate       = s.modifieddate,
         company_id         = s.company_id,
		 etlactiveind 		= 1,
		 etljobname 		= p_etljobname,
		 envsourcecd 		= p_envsourcecd ,
		 datasourcecd 		= p_datasourcecd ,
		 etlupdatedatetime 	= NOW()	
    FROM stg.stg_emod_company_mst s
    WHERE t.company_code  		= s.company_code
	AND t.serial_no 			= s.serial_no;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_Company
	(
		company_code,     address2,      phone_no,           status,              createddate,
		serial_no,        address3,       state,              effective_from,      modifiedby,
		ctimestamp,       city,           company_url,        para_base_flag,      modifieddate,
		company_name,     country,        par_comp_code,      reg_date,            company_id,
		address1,         zip_code,       base_currency,      createdby,		   etlactiveind,
        etljobname, 	  envsourcecd,    datasourcecd, 	  etlcreatedatetime
	)
	
    SELECT 
		s.company_code,     s.address2,       s.phone_no,           s.status,              s.createddate,
		s.serial_no,        s.address3,       s.state,              s.effective_from,      s.modifiedby,
		s.ctimestamp,        s.city,           s.company_url,        s.para_base_flag,      s.modifieddate,
		s.company_name,     s.country,        s.par_comp_code,      s.reg_date,            s.company_id,
		s.address1,         s.zip_code,       s.base_currency,      s.createdby,			1,
		p_etljobname,		p_envsourcecd,		p_datasourcecd,			NOW()
	FROM stg.stg_emod_company_mst s
    LEFT JOIN dwh.d_Company t
    ON 	s.company_code  		= t.company_code
	AND s.serial_no 			= t.serial_no
    WHERE t.company_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN
 
	
	INSERT INTO raw.raw_emod_company_mst
	(
	    company_code, serial_no, ctimestamp, company_name, address1, 
        address2, address3, city, country, zip_code,
        phone_no, state, company_url, mail_stop, telex,
        par_comp_code, fax_no, base_currency, parcur_cr_date, parcur_dl_date,
        status, effective_from, effective_to, para_base_flag, reg_date, 
        createdby, createddate, modifiedby, modifieddate, company_id, 
        latitude, longitude, etlcreateddatetime

	)
	SELECT 
		 company_code, serial_no, ctimestamp, company_name, address1, 
        address2, address3, city, country, zip_code,
        phone_no, state, company_url, mail_stop, telex,
        par_comp_code, fax_no, base_currency, parcur_cr_date, parcur_dl_date,
        status, effective_from, effective_to, para_base_flag, reg_date, 
        createdby, createddate, modifiedby, modifieddate, company_id, 
        latitude, longitude, etlcreateddatetime
	FROM stg.stg_emod_company_mst;
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