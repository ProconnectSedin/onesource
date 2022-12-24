CREATE OR REPLACE PROCEDURE dwh.usp_f_acapassethdr(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_acap_asset_hdr;

    UPDATE dwh.F_acapassethdr t
    SET
        a_timestamp             = s.timestamp,
        cap_date                = s.cap_date,
        cap_status              = s.cap_status,
        fb_id                   = s.fb_id,
        num_type                = s.num_type,
        asset_class             = s.asset_class,
        asset_group             = s.asset_group,
        cost_center             = s.cost_center,
        asset_desc              = s.asset_desc,
        asset_cost              = s.asset_cost,
        asset_location          = s.asset_location,
        seq_no                  = s.seq_no,
        as_on_date              = s.as_on_date,
        asset_type              = s.asset_type,
        asset_status            = s.asset_status,
        transaction_date        = s.transaction_date,
        createdby               = s.createdby,
        createddate             = s.createddate,
        modifiedby              = s.modifiedby,
        modifieddate            = s.modifieddate,
        remarks                 = s.remarks,
        LAccount_code           = s.LAccount_code,
        LAccount_desc           = s.LAccount_desc,
        Lcost_center            = s.Lcost_center,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_acap_asset_hdr s
    WHERE t.ou_id = s.ou_id
    AND t.cap_number = s.cap_number
    AND t.asset_number = s.asset_number;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_acapassethdr
    (
        ou_id			, cap_number	, asset_number	, a_timestamp		, cap_date, 
		cap_status		, fb_id			, num_type		, asset_class		, asset_group, 
		cost_center		, asset_desc	, asset_cost	, asset_location	, seq_no, 
		as_on_date		, asset_type	, asset_status	, transaction_date	, createdby, 
		createddate		, modifiedby	, modifieddate	, remarks			, LAccount_code, 
		LAccount_desc	, Lcost_center	, 
		etlactiveind	, etljobname	, envsourcecd	, datasourcecd		, etlcreatedatetime
    )

    SELECT
        s.ou_id			, s.cap_number	, s.asset_number, s.timestamp		, s.cap_date, 
		s.cap_status	, s.fb_id		, s.num_type	, s.asset_class		, s.asset_group, 
		s.cost_center	, s.asset_desc	, s.asset_cost	, s.asset_location	, s.seq_no, 
		s.as_on_date	, s.asset_type	, s.asset_status, s.transaction_date, s.createdby, 
		s.createddate	, s.modifiedby	, s.modifieddate, s.remarks			, s.LAccount_code, 
		s.LAccount_desc	, s.Lcost_center, 
				1		, p_etljobname	, p_envsourcecd	, p_datasourcecd	, NOW()
    FROM stg.stg_acap_asset_hdr s
    LEFT JOIN dwh.F_acapassethdr t
    ON s.ou_id = t.ou_id
    AND s.cap_number = t.cap_number
    AND s.asset_number = t.asset_number
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_acap_asset_hdr
    (
        ou_id				, cap_number		, asset_number		, timestamp			, cap_date, 
		cap_status			, fb_id				, num_type			, asset_class		, asset_group, 
		cost_center			, asset_desc		, asset_cost		, asset_location	, seq_no, 
		as_on_date			, asset_type		, asset_status		, transaction_date	, account_code, 
		asset_cost_befround	, asset_cost_diff	, createdby			, createddate		, modifiedby, 
		modifieddate		, remarks			, workflow_status	, workflow_error	, LAccount_code, 
		LAccount_desc		, Lcost_center		, LAnalysis_code	, LSubAnalysis_code	, asset_classification, 
		asset_category		, asset_cluster		, etlcreateddatetime
    )
    SELECT
        ou_id				, cap_number		, asset_number		, timestamp			, cap_date, 
		cap_status			, fb_id				, num_type			, asset_class		, asset_group, 
		cost_center			, asset_desc		, asset_cost		, asset_location	, seq_no, 
		as_on_date			, asset_type		, asset_status		, transaction_date	, account_code, 
		asset_cost_befround	, asset_cost_diff	, createdby			, createddate		, modifiedby, 
		modifieddate		, remarks			, workflow_status	, workflow_error	, LAccount_code, 
		LAccount_desc		, Lcost_center		, LAnalysis_code	, LSubAnalysis_code	, asset_classification, 
		asset_category		, asset_cluster		, etlcreateddatetime
	FROM stg.stg_acap_asset_hdr;
    
    END IF;
	
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert	(	p_sourceid, p_targetobject, p_dataflowflag,
									p_batchid,p_taskname, 'sp_ExceptionHandling', 
									p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
	   
END;
$$;