CREATE PROCEDURE dwh.usp_f_eamamchdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_eam_amc_hdr;

    UPDATE dwh.F_eamamchdr t
    SET
		amc_vendor_key				= COALESCE(v.vendor_key,-1),
		amc_curr_key				= COALESCE(cr.curr_key,-1),
        amc_timestamp               = s.amc_timestamp,
        amc_Type                    = s.amc_Type,
        amc_Pay_Mode                = s.amc_Pay_Mode,
        amc_Freq                    = s.amc_Freq,
        amc_amcamount               = s.amc_amcamount,
        amc_PONo                    = s.amc_PONo,
        amc_Supp_AMCRefNo           = s.amc_Supp_AMCRefNo,
        amc_Curr                    = s.amc_Curr,
        amc_Cont_Person             = s.amc_Cont_Person,
        amc_MailID                  = s.amc_MailID,
        amc_createdby               = s.amc_createdby,
        amc_modifiedby              = s.amc_modifiedby,
        amc_modifieddate            = s.amc_modifieddate,
        amc_status                  = s.amc_status,
        amc_bill_basedon            = s.amc_bill_basedon,
        amc_Exp_Opt                 = s.amc_Exp_Opt,
        amc_inv_type                = s.amc_inv_type,
        amc_fixed_rate              = s.amc_fixed_rate,
        amc_rate_exc_param          = s.amc_rate_exc_param,
        amc_remarks                 = s.amc_remarks,
        amc_doctyp                  = s.amc_doctyp,
        amc_doclineno               = s.amc_doclineno,
        amc_agr_pre_visit           = s.amc_agr_pre_visit,
        amc_agr_brkdwn_visit        = s.amc_agr_brkdwn_visit,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_eam_amc_hdr s
	LEFT JOIN dwh.d_vendor v
		ON  s.amc_SuppCode			= v.vendor_id
		AND s.amc_amcou				= v.vendor_ou
	LEFT JOIN dwh.d_currency cr
		ON  s.amc_Curr				= cr.iso_curr_code	
    WHERE t.amc_amcno 				= s.amc_amcno
    AND t.amc_amcou 				= s.amc_amcou
    AND t.amc_date 					= s.amc_date
    AND t.amc_fromdate 				= s.amc_fromdate
    AND t.amc_todate 				= s.amc_todate
    AND t.amc_RevNo 				= s.amc_RevNo
    AND t.amc_SuppCode 				= s.amc_SuppCode
    AND t.amc_createdate 			= s.amc_createdate;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_eamamchdr
    (
        amc_vendor_key, amc_curr_key, amc_amcno, amc_amcou, amc_date, amc_fromdate, amc_todate, amc_RevNo, amc_timestamp, amc_Type, amc_Pay_Mode, amc_Freq, amc_SuppCode, amc_amcamount, amc_PONo, amc_Supp_AMCRefNo, amc_Curr, amc_Cont_Person, amc_MailID, amc_createdby, amc_createdate, amc_modifiedby, amc_modifieddate, amc_status, amc_bill_basedon, amc_Exp_Opt, amc_inv_type, amc_fixed_rate, amc_rate_exc_param, amc_remarks, amc_doctyp, amc_doclineno, amc_agr_pre_visit, amc_agr_brkdwn_visit, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(v.vendor_key,-1), COALESCE(cr.curr_key,-1), s.amc_amcno, s.amc_amcou, s.amc_date, s.amc_fromdate, s.amc_todate, s.amc_RevNo, s.amc_timestamp, s.amc_Type, s.amc_Pay_Mode, s.amc_Freq, s.amc_SuppCode, s.amc_amcamount, s.amc_PONo, s.amc_Supp_AMCRefNo, s.amc_Curr, s.amc_Cont_Person, s.amc_MailID, s.amc_createdby, s.amc_createdate, s.amc_modifiedby, s.amc_modifieddate, s.amc_status, s.amc_bill_basedon, s.amc_Exp_Opt, s.amc_inv_type, s.amc_fixed_rate, s.amc_rate_exc_param, s.amc_remarks, s.amc_doctyp, s.amc_doclineno, s.amc_agr_pre_visit, s.amc_agr_brkdwn_visit, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_eam_amc_hdr s
	LEFT JOIN dwh.d_vendor v
		ON  s.amc_SuppCode			= v.vendor_id
		AND s.amc_amcou				= v.vendor_ou
	LEFT JOIN dwh.d_currency cr
		ON  s.amc_Curr				= cr.iso_curr_code	
    LEFT JOIN dwh.F_eamamchdr t
    ON s.amc_amcno 					= t.amc_amcno
    AND s.amc_amcou 				= t.amc_amcou
    AND s.amc_date 					= t.amc_date
    AND s.amc_fromdate 				= t.amc_fromdate
    AND s.amc_todate 				= t.amc_todate
    AND s.amc_RevNo 				= t.amc_RevNo
    AND s.amc_SuppCode 				= t.amc_SuppCode
    AND s.amc_createdate 			= t.amc_createdate
    WHERE t.amc_amcno IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_eam_amc_hdr
    (
        amc_amcno, amc_amcou, amc_date, amc_fromdate, amc_todate, amc_RevNo, amc_timestamp, amc_lastrev_date, amc_Type, amc_Pay_Mode, amc_Freq, amc_SuppCode, amc_amcamount, amc_PONo, amc_Supp_AMCRefNo, amc_Curr, amc_Cont_Person, amc_Cont_No, amc_MailID, amc_createdby, amc_createdate, amc_modifiedby, amc_modifieddate, amc_status, amc_bill_basedon, amc_Exp_Opt, amc_inv_type, amc_exp_param_val, amc_fixed_rate, amc_max_param_val, amc_rate_exc_param, amc_reas_for_rev, amc_expiry_param, amc_remarks, amc_param_uom, amc_doctyp, amc_doclineno, amc_showstopper, amc_medium, amc_low, amc_critical, amc_agr_pre_visit, amc_agr_brkdwn_visit, etlcreateddatetime
    )
    SELECT
        amc_amcno, amc_amcou, amc_date, amc_fromdate, amc_todate, amc_RevNo, amc_timestamp, amc_lastrev_date, amc_Type, amc_Pay_Mode, amc_Freq, amc_SuppCode, amc_amcamount, amc_PONo, amc_Supp_AMCRefNo, amc_Curr, amc_Cont_Person, amc_Cont_No, amc_MailID, amc_createdby, amc_createdate, amc_modifiedby, amc_modifieddate, amc_status, amc_bill_basedon, amc_Exp_Opt, amc_inv_type, amc_exp_param_val, amc_fixed_rate, amc_max_param_val, amc_rate_exc_param, amc_reas_for_rev, amc_expiry_param, amc_remarks, amc_param_uom, amc_doctyp, amc_doclineno, amc_showstopper, amc_medium, amc_low, amc_critical, amc_agr_pre_visit, amc_agr_brkdwn_visit, etlcreateddatetime
    FROM stg.stg_eam_amc_hdr;
    
    END IF;
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;