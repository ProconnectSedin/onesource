CREATE OR REPLACE PROCEDURE dwh.usp_f_tbpvoucherhdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_tbp_voucher_hdr;

    UPDATE dwh.F_tbpvoucherhdr t
    SET
		company_key				= COALESCE(c.company_key,-1),
        s_timestamp            = s.timestamp,
        tran_type              = s.tran_type,
        tran_date              = s.tran_date,
        fb_voucher_date        = s.fb_voucher_date,
        createdby              = s.createdby,
        createddate            = s.createddate,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_tbp_voucher_hdr s
	LEFT JOIN dwh.d_company c
	ON c.company_code= s.company_code
    WHERE t.current_key = s.current_key
    AND t.company_code = s.company_code
    AND t.component_name = s.component_name
    AND t.bu_id = s.bu_id
    AND t.fb_id = s.fb_id
    AND t.fb_voucher_no = s.fb_voucher_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_tbpvoucherhdr
    (
		company_key,
        current_key, company_code, component_name, bu_id, fb_id, 
		fb_voucher_no, s_timestamp, tran_type, tran_date, fb_voucher_date,
		createdby, createddate, 
		etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(c.company_key,-1),
        s.current_key, s.company_code, s.component_name, s.bu_id, s.fb_id, 
		s.fb_voucher_no, s.timestamp, s.tran_type, s.tran_date, s.fb_voucher_date, 
		s.createdby, s.createddate, 
		1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tbp_voucher_hdr s
	LEFT JOIN dwh.d_company c
	ON c.company_code= s.company_code
    LEFT JOIN dwh.F_tbpvoucherhdr t
    ON s.current_key = t.current_key
    AND s.company_code = t.company_code
    AND s.component_name = t.component_name
    AND s.bu_id = t.bu_id
    AND s.fb_id = t.fb_id
    AND s.fb_voucher_no = t.fb_voucher_no
    WHERE t.current_key IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tbp_voucher_hdr
    (
        current_key, company_code, component_name, bu_id, fb_id,
		fb_voucher_no, timestamp, tran_type, tran_date, fb_voucher_date, 
		con_ref_voucher_no, createdby, createddate, modifiedby, modifieddate, 
		etlcreateddatetime
    )
    SELECT
        current_key, company_code, component_name, bu_id, fb_id, 
		fb_voucher_no, timestamp, tran_type, tran_date, fb_voucher_date, 
		con_ref_voucher_no, createdby, createddate, modifiedby, modifieddate, 
		etlcreateddatetime
    FROM stg.stg_tbp_voucher_hdr;
    
    END IF;
	
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, 
								p_batchid,p_taskname, 'sp_ExceptionHandling', 
								p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
	   
END;
$$;