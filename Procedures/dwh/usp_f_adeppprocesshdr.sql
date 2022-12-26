CREATE OR REPLACE PROCEDURE dwh.usp_f_adeppprocesshdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_adepp_process_hdr;

    UPDATE dwh.F_adeppprocesshdr t
    SET
        a_timestamp            = s.timestamp,
        process_status         = s.process_status,
        process_date           = s.process_date,
        fb_id                  = s.fb_id,
        num_type               = s.num_type,
        incl_rev               = s.incl_rev,
        currency               = s.currency,
        pcost_center           = s.pcost_center,
        fin_year               = s.fin_year,
        fp_upto                = s.fp_upto,
        fp_start_date          = s.fp_start_date,
        fp_end_date            = s.fp_end_date,
        depr_basis             = s.depr_basis,
        asset_class            = s.asset_class,
        depr_category          = s.depr_category,
        asset_number           = s.asset_number,
        assets_selected        = s.assets_selected,
        tag_selected           = s.tag_selected,
        rec_selected           = s.rec_selected,
        susp_total             = s.susp_total,
        depr_total             = s.depr_total,
        rev_depr_total         = s.rev_depr_total,
        createdby              = s.createdby,
        createddate            = s.createddate,
        modifiedby             = s.modifiedby,
        modifieddate           = s.modifieddate,
        fystartdate            = s.fystartdate,
        fyenddate              = s.fyenddate,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_adepp_process_hdr s
    WHERE t.ou_id = s.ou_id
    AND t.depr_proc_runno = s.depr_proc_runno
    AND t.depr_book = s.depr_book;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_adeppprocesshdr
    (
        ou_id			, depr_proc_runno	, depr_book		, a_timestamp	, process_status, 
		process_date	, fb_id				, num_type		, incl_rev		, currency, 
		pcost_center	, fin_year			, fp_upto		, fp_start_date	, fp_end_date, 
		depr_basis		, asset_class		, depr_category	, asset_number	, assets_selected, 
		tag_selected	, rec_selected		, susp_total	, depr_total	, rev_depr_total, 
		createdby		, createddate		, modifiedby	, modifieddate	, fystartdate, 
		fyenddate		, 
		etlactiveind	, etljobname		, envsourcecd	, datasourcecd	, etlcreatedatetime
    )

    SELECT
        s.ou_id			, s.depr_proc_runno	, s.depr_book		, s.timestamp		, s.process_status, 
		s.process_date	, s.fb_id			, s.num_type		, s.incl_rev		, s.currency, 
		s.pcost_center	, s.fin_year		, s.fp_upto			, s.fp_start_date	, s.fp_end_date,
		s.depr_basis	, s.asset_class		, s.depr_category	, s.asset_number	, s.assets_selected, 
		s.tag_selected	, s.rec_selected	, s.susp_total		, s.depr_total		, s.rev_depr_total, 
		s.createdby		, s.createddate		, s.modifiedby		, s.modifieddate	, s.fystartdate, 
		s.fyenddate		, 
			1			, p_etljobname		, p_envsourcecd		, p_datasourcecd	, NOW()
    FROM stg.stg_adepp_process_hdr s
    LEFT JOIN dwh.F_adeppprocesshdr t
    ON s.ou_id = t.ou_id
    AND s.depr_proc_runno = t.depr_proc_runno
    AND s.depr_book = t.depr_book
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_adepp_process_hdr
    (
        ou_id				, depr_proc_runno	, depr_book		, timestamp		, process_status, 
		process_date		, fb_id				, num_type		, incl_rev		, currency, 
		pcost_center		, fin_year			, fp_upto		, fp_start_date	, fp_end_date, 
		depr_basis			, asset_class		, depr_category	, asset_number	, cost_center, 
		assets_selected		, tag_selected		, rec_selected	, susp_total	, depr_total, 
		rev_depr_total		, rev_susp_total	, pbc_susp_total, pbc_depr_total, pbc_rev_depr_total,
		pbc_rev_susp_total	, createdby			, createddate	, modifiedby	, modifieddate, 
		fystartdate			, fyenddate			, Asset_group	, Asset_location, etlcreateddatetime
    )
    SELECT
	    ou_id				, depr_proc_runno	, depr_book		, timestamp		, process_status, 
		process_date		, fb_id				, num_type		, incl_rev		, currency, 
		pcost_center		, fin_year			, fp_upto		, fp_start_date	, fp_end_date, 
		depr_basis			, asset_class		, depr_category	, asset_number	, cost_center, 
		assets_selected		, tag_selected		, rec_selected	, susp_total	, depr_total, 
		rev_depr_total		, rev_susp_total	, pbc_susp_total, pbc_depr_total, pbc_rev_depr_total,
		pbc_rev_susp_total	, createdby			, createddate	, modifiedby	, modifieddate, 
		fystartdate			, fyenddate			, Asset_group	, Asset_location, etlcreateddatetime
    FROM stg.stg_adepp_process_hdr;
    
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