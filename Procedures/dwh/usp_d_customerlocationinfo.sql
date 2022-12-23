CREATE PROCEDURE dwh.usp_d_customerlocationinfo(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    WHERE   d.sourceid      = p_sourceId 
        AND d.dataflowflag  = p_dataflowflag
        AND d.targetobject  = p_targetobject;
        
    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_cust_lo_info;

    UPDATE dwh.d_CustomerLocationInfo t
    SET 
 
        
        clo_cust_name  =        s.clo_cust_name,
        clo_cust_name_shd  =        s.clo_cust_name_shd,
        clo_created_at  =        s.clo_created_at,
        clo_registration_dt  =        s.clo_registration_dt,
        clo_portal_user  =        s.clo_portal_user,
        clo_prosp_cust_code  =        s.clo_prosp_cust_code,
        clo_parent_cust_code  =        s.clo_parent_cust_code,
        clo_supp_code  =        s.clo_supp_code,
        clo_number_type  =        s.clo_number_type,
        clo_addrline1  =        s.clo_addrline1,
        clo_addrline2  =        s.clo_addrline2,
        clo_addrline3  =        s.clo_addrline3,
        clo_city  =        s.clo_city,
        clo_state  =        s.clo_state,
        clo_country  =        s.clo_country,
        clo_zip  =        s.clo_zip,
        clo_phone1  =        s.clo_phone1,
        clo_phone2  =        s.clo_phone2,
        clo_mobile  =        s.clo_mobile,
        clo_fax  =        s.clo_fax,
        clo_email  =        s.clo_email,
        clo_url  =        s.clo_url,
        clo_cr_chk_at  =        s.clo_cr_chk_at,
        clo_nature_of_cust  =        s.clo_nature_of_cust,
        clo_internal_bu  =        s.clo_internal_bu,
        clo_internal_company  =        s.clo_internal_company,
        clo_account_group_code  =        s.clo_account_group_code,
        clo_created_by  =        s.clo_created_by,
        clo_created_date  =        s.clo_created_date,
        clo_modified_by  =        s.clo_modified_by,
        clo_modified_date  =        s.clo_modified_date,
        clo_timestamp_value  =        s.clo_timestamp_value,
        clo_cust_long_desc  =        s.clo_cust_long_desc,
        CLO_NOC  =        s.CLO_NOC,
        clo_template  =        s.clo_template,
        clo_pannumber  =        s.clo_pannumber,

        etlactiveind           =     1,
        etljobname             =     p_etljobname,
        envsourcecd            =     p_envsourcecd,
        datasourcecd           =     p_datasourcecd,
        etlupdatedatetime      =     NOW()  
    FROM stg.stg_cust_lo_info s
    WHERE t.clo_lo     = s.clo_lo
    AND   t.clo_cust_code    = s.clo_cust_code;
  
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_CustomerLocationInfo
    (clo_lo,  clo_cust_code,  clo_cust_name,  clo_cust_name_shd,  clo_created_at,  clo_registration_dt,  clo_portal_user,  clo_prosp_cust_code,  clo_parent_cust_code,  clo_supp_code,  clo_number_type,  clo_addrline1,  clo_addrline2,  clo_addrline3,  clo_city,  clo_state,  clo_country,  clo_zip,  clo_phone1,  clo_phone2,  clo_mobile,  clo_fax,  clo_email,  clo_url,  clo_cr_chk_at,  clo_nature_of_cust,  clo_internal_bu,  clo_internal_company,  clo_account_group_code,  clo_created_by,  clo_created_date,  clo_modified_by,  clo_modified_date,  clo_timestamp_value,  clo_cust_long_desc,  CLO_NOC,  clo_template,  clo_pannumber, etlactiveind,
        etljobname,         envsourcecd,    datasourcecd,       etlcreatedatetime
    )
    
    SELECT 
        s.clo_lo,  s.clo_cust_code,  s.clo_cust_name,  s.clo_cust_name_shd,  s.clo_created_at,  s.clo_registration_dt,  s.clo_portal_user,  s.clo_prosp_cust_code,  s.clo_parent_cust_code,  s.clo_supp_code,  s.clo_number_type,  s.clo_addrline1,  s.clo_addrline2,  s.clo_addrline3,  s.clo_city,  s.clo_state,  s.clo_country,  s.clo_zip,  s.clo_phone1,  s.clo_phone2,  s.clo_mobile,  s.clo_fax,  s.clo_email,  s.clo_url,  s.clo_cr_chk_at,  s.clo_nature_of_cust,  s.clo_internal_bu,  s.clo_internal_company,  s.clo_account_group_code,  s.clo_created_by,  s.clo_created_date,  s.clo_modified_by,  s.clo_modified_date,  s.clo_timestamp_value,  s.clo_cust_long_desc,  s.CLO_NOC,  s.clo_template,  s.clo_pannumber,
        1,      p_etljobname,       p_envsourcecd,      p_datasourcecd,         now()
    FROM stg.stg_cust_lo_info s
    LEFT JOIN dwh.d_CustomerLocationInfo t
    ON s.clo_lo     = t.clo_lo 
    AND  s.clo_cust_code    = t.clo_cust_code
   
    WHERE t.clo_lo   IS NULL;

    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	IF p_rawstorageflag = 1
	THEN

    INSERT INTO raw.raw_cust_lo_info

    (
        clo_lo, clo_cust_code, clo_cust_name, clo_cust_name_shd, clo_created_at,
        clo_registration_dt, clo_portal_user, clo_prosp_cust_code, clo_parent_cust_code, 
        clo_supp_code, clo_number_type, clo_addrline1, clo_addrline2, clo_addrline3, 
        clo_city, clo_state, clo_country, clo_zip, clo_phone1, clo_phone2, clo_mobile, 
        clo_fax, clo_email, clo_url, clo_cr_chk_at, clo_nature_of_cust, clo_internal_bu, 
        clo_internal_company, clo_account_group_code, clo_created_by, clo_created_date, 
        clo_modified_by, clo_modified_date, clo_timestamp_value, clo_addnl1, clo_addnl2, 
        clo_addnl3, clo_cust_long_desc, clo_noc, clo_template, clo_registration_no, 
        clo_registration_type, clo_pannumber, clo_noc_onetime, clo_cust_price_grp, 
        clo_cust_tax_grp, clo_cust_disc_grp, clo_job_tilte, etlcreateddatetime
    )
    SELECT
        clo_lo, clo_cust_code, clo_cust_name, clo_cust_name_shd, clo_created_at,
        clo_registration_dt, clo_portal_user, clo_prosp_cust_code, clo_parent_cust_code, 
        clo_supp_code, clo_number_type, clo_addrline1, clo_addrline2, clo_addrline3, 
        clo_city, clo_state, clo_country, clo_zip, clo_phone1, clo_phone2, clo_mobile, 
        clo_fax, clo_email, clo_url, clo_cr_chk_at, clo_nature_of_cust, clo_internal_bu, 
        clo_internal_company, clo_account_group_code, clo_created_by, clo_created_date, 
        clo_modified_by, clo_modified_date, clo_timestamp_value, clo_addnl1, clo_addnl2, 
        clo_addnl3, clo_cust_long_desc, clo_noc, clo_template, clo_registration_no, 
        clo_registration_type, clo_pannumber, clo_noc_onetime, clo_cust_price_grp, 
        clo_cust_tax_grp, clo_cust_disc_grp, clo_job_tilte, etlcreateddatetime
    FROM stg.stg_cust_lo_info;
	
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
    
    --SELECT COUNT(*) INTO InsCnt FROM dwh.usp_d_CustomerLocationInfo;
END;
$$;