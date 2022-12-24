CREATE OR REPLACE PROCEDURE dwh.usp_f_fbpvoucherdtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename,h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname,p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_fbp_voucher_dtl;

  
    

    UPDATE dwh.F_fbpvoucherdtl t
    SET
        fbp_company_key        = COALESCE(c.company_key,-1),
        parent_key              = s.parent_key,
        current_key             = s.current_key,
        company_code            = s.company_code,
        ou_id                   = s.ou_id,
        fb_id                   = s.fb_id,
        fb_voucher_no           = s.fb_voucher_no,
        serial_no               = s.serial_no,
        timestamp               = s.timestamp,
        account_code            = s.account_code,
        drcr_flag               = s.drcr_flag,
        cost_center             = s.cost_center,
        analysis_code           = s.analysis_code,
        subanalysis_code        = s.subanalysis_code,
        base_amount             = s.base_amount,
        par_base_amount         = s.par_base_amount,
        createdby               = s.createdby,
        createddate             = s.createddate,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_fbp_voucher_dtl s
       LEFT JOIN dwh.d_company C      
        ON s.company_code  = C.company_code 
    
    WHERE t.parent_key = s.parent_key
    AND t.current_key = s.current_key
    AND t.company_code = s.company_code
    AND t.ou_id = s.ou_id
    AND t.fb_id = s.fb_id
    AND t.fb_voucher_no = s.fb_voucher_no
    AND t.serial_no = s.serial_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_fbpvoucherdtl
    (
        fbp_company_key , parent_key, current_key, company_code, ou_id, fb_id, fb_voucher_no, serial_no, timestamp, account_code, drcr_flag, cost_center, analysis_code, subanalysis_code, base_amount, par_base_amount, createdby, createddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
   COALESCE(c.company_key,-1), s.parent_key, s.current_key, s.company_code, s.ou_id, s.fb_id, s.fb_voucher_no, s.serial_no, s.timestamp, s.account_code, s.drcr_flag, s.cost_center, s.analysis_code, s.subanalysis_code, s.base_amount, s.par_base_amount, s.createdby, s.createddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_fbp_voucher_dtl s

       LEFT JOIN dwh.d_company C      
        ON s.company_code  = C.company_code 
    LEFT JOIN dwh.F_fbpvoucherdtl t
    ON s.parent_key = t.parent_key
    AND s.current_key = t.current_key
    AND s.company_code = t.company_code
    AND s.ou_id = t.ou_id
    AND s.fb_id = t.fb_id
    AND s.fb_voucher_no = t.fb_voucher_no
    AND s.serial_no = t.serial_no
    WHERE t.parent_key IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_fbp_voucher_dtl
    (
        parent_key, current_key, company_code, ou_id, fb_id, fb_voucher_no, serial_no, timestamp, account_code, drcr_flag, cost_center, analysis_code, subanalysis_code, base_amount, par_base_amount, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        parent_key, current_key, company_code, ou_id, fb_id, fb_voucher_no, serial_no, timestamp, account_code, drcr_flag, cost_center, analysis_code, subanalysis_code, base_amount, par_base_amount, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_fbp_voucher_dtl;
    
    END IF;
   /* EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;*/
END;
$$;