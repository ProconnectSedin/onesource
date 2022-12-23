CREATE PROCEDURE dwh.usp_d_assetaccountmaster(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_ard_asset_account_mst;

    UPDATE dwh.d_assetAccountMaster t
    SET
        timestamp             = s.timestamp,
        account_code          = s.account_code,
        effective_to          = s.effective_to,
        resou_id              = s.resou_id,
        createdby             = s.createdby,
        createddate           = s.createddate,
        modifiedby            = s.modifiedby,
        modifieddate          = s.modifieddate,
        etlactiveind          = 1,
        etljobname            = p_etljobname,
        envsourcecd           = p_envsourcecd,
        datasourcecd          = p_datasourcecd,
        etlupdatedatetime     = NOW()
    FROM stg.stg_ard_asset_account_mst s
    WHERE t.company_code = s.company_code
    AND t.fb_id = s.fb_id
    AND t.asset_class = s.asset_class
    AND t.asset_usage = s.asset_usage
    AND t.effective_from = s.effective_from
    AND t.sequence_no = s.sequence_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_assetAccountMaster
    (
        company_code, fb_id, asset_class, asset_usage, effective_from, sequence_no, timestamp, account_code, effective_to, resou_id, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.company_code, s.fb_id, s.asset_class, s.asset_usage, s.effective_from, s.sequence_no, s.timestamp, s.account_code, s.effective_to, s.resou_id, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_ard_asset_account_mst s
    LEFT JOIN dwh.d_assetAccountMaster t
    ON s.company_code = t.company_code
    AND s.fb_id = t.fb_id
    AND s.asset_class = t.asset_class
    AND s.asset_usage = t.asset_usage
    AND s.effective_from = t.effective_from
    AND s.sequence_no = t.sequence_no
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

    INSERT INTO raw.raw_ard_asset_account_mst
    (
        company_code, fb_id, asset_class, asset_usage, effective_from, sequence_no, timestamp, account_code, effective_to, resou_id, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        company_code, fb_id, asset_class, asset_usage, effective_from, sequence_no, timestamp, account_code, effective_to, resou_id, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_ard_asset_account_mst;

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