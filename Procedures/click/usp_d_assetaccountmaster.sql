CREATE PROCEDURE click.usp_d_assetaccountmaster()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_assetaccountmaster t
    SET
        d_asset_mst_key = s.d_asset_mst_key,
        company_code = s.company_code,
        fb_id = s.fb_id,
        asset_class = s.asset_class,
        asset_usage = s.asset_usage,
        effective_from = s.effective_from,
        sequence_no = s.sequence_no,
        timestamp = s.timestamp,
        account_code = s.account_code,
        effective_to = s.effective_to,
        resou_id = s.resou_id,
        createdby = s.createdby,
        createddate = s.createddate,
        modifiedby = s.modifiedby,
        modifieddate = s.modifieddate,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_assetaccountmaster s
    WHERE t.company_code = s.company_code
    AND t.fb_id = s.fb_id
    AND t.asset_class = s.asset_class
    AND t.asset_usage = s.asset_usage
    AND t.effective_from = s.effective_from
    AND t.sequence_no = s.sequence_no;

    INSERT INTO click.d_assetaccountmaster(d_asset_mst_key, company_code, fb_id, asset_class, asset_usage, effective_from, sequence_no, timestamp, account_code, effective_to, resou_id, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.d_asset_mst_key, s.company_code, s.fb_id, s.asset_class, s.asset_usage, s.effective_from, s.sequence_no, s.timestamp, s.account_code, s.effective_to, s.resou_id, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_assetaccountmaster s
    LEFT JOIN click.d_assetaccountmaster t
    ON t.company_code = s.company_code
    AND t.fb_id = s.fb_id
    AND t.asset_class = s.asset_class
    AND t.asset_usage = s.asset_usage
    AND t.effective_from = s.effective_from
    AND t.sequence_no = s.sequence_no
    WHERE t.company_code IS NULL;
END;
$$;