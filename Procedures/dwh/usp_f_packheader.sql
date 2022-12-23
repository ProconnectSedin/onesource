CREATE PROCEDURE dwh.usp_f_packheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_pack_hdr;

    UPDATE dwh.F_PackHeader t
    SET
        pack_location               = s.wms_pack_location,
        pack_ou                     = s.wms_pack_ou,
        pack_pack_rule              = s.wms_pack_pack_rule,
        pack_single_step            = s.wms_pack_single_step,
        pack_by_customer            = s.wms_pack_by_customer,
        pack_by_item                = s.wms_pack_by_item,
        pack_by_pick_numb           = s.wms_pack_by_pick_numb,
        pack_storage_pickbay        = s.wms_pack_storage_pickbay,
        pack_load_balancing         = s.wms_pack_load_balancing,
        pack_item_type              = s.wms_pack_item_type,
        pack_timestamp              = s.wms_pack_timestamp,
        pack_created_by             = s.wms_pack_created_by,
        pack_created_date           = s.wms_pack_created_date,
        pack_modified_by            = s.wms_pack_modified_by,
        pack_modified_date          = s.wms_pack_modified_date,
        pack_step                   = s.wms_pack_step,
        pack_short_pick             = s.wms_pack_short_pick,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_wms_pack_hdr s
    WHERE t.pack_location = s.wms_pack_location
    AND t.pack_ou = s.wms_pack_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PackHeader
    (
        pack_location, pack_ou, pack_pack_rule, pack_single_step, pack_by_customer, pack_by_item, pack_by_pick_numb, pack_storage_pickbay, pack_load_balancing, pack_item_type, pack_timestamp, pack_created_by, pack_created_date, pack_modified_by, pack_modified_date, pack_step, pack_short_pick, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.wms_pack_location, s.wms_pack_ou, s.wms_pack_pack_rule, s.wms_pack_single_step, s.wms_pack_by_customer, s.wms_pack_by_item, s.wms_pack_by_pick_numb, s.wms_pack_storage_pickbay, s.wms_pack_load_balancing, s.wms_pack_item_type, s.wms_pack_timestamp, s.wms_pack_created_by, s.wms_pack_created_date, s.wms_pack_modified_by, s.wms_pack_modified_date, s.wms_pack_step, s.wms_pack_short_pick, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_pack_hdr s
    LEFT JOIN dwh.F_PackHeader t
    ON s.wms_pack_location = t.pack_location
    AND s.wms_pack_ou = t.pack_ou
    WHERE t.pack_location IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_pack_hdr
    (
        wms_pack_location, wms_pack_ou, wms_pack_pack_rule, wms_pack_single_step, wms_pack_two_step, wms_pack_by_customer, wms_pack_by_item, wms_pack_by_pick_numb, wms_pack_storage_pickbay, wms_pack_load_balancing, wms_pack_item_type, wms_pack_timestamp, wms_pack_created_by, wms_pack_created_date, wms_pack_modified_by, wms_pack_modified_date, wms_pack_userdefined1, wms_pack_userdefined2, wms_pack_userdefined3, wms_pack_step, wms_pack_short_pick, etlcreateddatetime
    )
    SELECT
        wms_pack_location, wms_pack_ou, wms_pack_pack_rule, wms_pack_single_step, wms_pack_two_step, wms_pack_by_customer, wms_pack_by_item, wms_pack_by_pick_numb, wms_pack_storage_pickbay, wms_pack_load_balancing, wms_pack_item_type, wms_pack_timestamp, wms_pack_created_by, wms_pack_created_date, wms_pack_modified_by, wms_pack_modified_date, wms_pack_userdefined1, wms_pack_userdefined2, wms_pack_userdefined3, wms_pack_step, wms_pack_short_pick, etlcreateddatetime
    FROM stg.stg_wms_pack_hdr;
    
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