CREATE PROCEDURE dwh.usp_d_tariffservice(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_tariff_service_hdr;

    UPDATE dwh.D_TariffService t	
    SET
        tf_ser_desc                     = s.wms_tf_ser_desc,
        tf_ser_status                   = s.wms_tf_ser_status,
        tf_ser_valid_from               = s.wms_tf_ser_valid_from,
        tf_ser_valid_to                 = s.wms_tf_ser_valid_to,
        tf_ser_service_period           = s.wms_tf_ser_service_period,
        tf_ser_uom                      = s.wms_tf_ser_uom,
        tf_ser_service_level_per        = s.wms_tf_ser_service_level_per,
        tf_ser_reason_code              = s.wms_tf_ser_reason_code,
        tf_ser_timestamp                = s.wms_tf_ser_timestamp,
        tf_ser_created_by               = s.wms_tf_ser_created_by,
        tf_ser_created_dt               = s.wms_tf_ser_created_dt,
        tf_ser_modified_by              = s.wms_tf_ser_modified_by,
        tf_ser_modified_dt              = s.wms_tf_ser_modified_dt,
        etlactiveind                    = 1,
        etljobname                      = p_etljobname,
        envsourcecd                     = p_envsourcecd,
        datasourcecd                    = p_datasourcecd,
        etlupdatedatetime               = NOW()
    FROM stg.stg_wms_tariff_service_hdr s
    WHERE t.tf_ser_id = s.wms_tf_ser_id
    AND t.tf_ser_ou = s.wms_tf_ser_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_TariffService
    (
        tf_ser_id, tf_ser_ou, tf_ser_desc, tf_ser_status, tf_ser_valid_from, tf_ser_valid_to, tf_ser_service_period, tf_ser_uom, tf_ser_service_level_per, tf_ser_reason_code, tf_ser_timestamp, tf_ser_created_by, tf_ser_created_dt, tf_ser_modified_by, tf_ser_modified_dt, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.wms_tf_ser_id, s.wms_tf_ser_ou, s.wms_tf_ser_desc, s.wms_tf_ser_status, s.wms_tf_ser_valid_from, s.wms_tf_ser_valid_to, s.wms_tf_ser_service_period, s.wms_tf_ser_uom, s.wms_tf_ser_service_level_per, s.wms_tf_ser_reason_code, s.wms_tf_ser_timestamp, s.wms_tf_ser_created_by, s.wms_tf_ser_created_dt, s.wms_tf_ser_modified_by, s.wms_tf_ser_modified_dt, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_tariff_service_hdr s
    LEFT JOIN dwh.D_TariffService t
    ON s.wms_tf_ser_id = t.tf_ser_id
    AND s.wms_tf_ser_ou = t.tf_ser_ou
    WHERE t.tf_ser_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN


    INSERT INTO raw.raw_wms_tariff_service_hdr
    (
        wms_tf_ser_id, wms_tf_ser_ou, wms_tf_ser_desc, wms_tf_ser_status, wms_tf_ser_valid_from, wms_tf_ser_valid_to, wms_tf_ser_service_period, wms_tf_ser_uom, wms_tf_ser_service_level_per, wms_tf_ser_reason_code, wms_tf_ser_timestamp, wms_tf_ser_created_by, wms_tf_ser_created_dt, wms_tf_ser_modified_by, wms_tf_ser_modified_dt, etlcreateddatetime
    )
    SELECT
        wms_tf_ser_id, wms_tf_ser_ou, wms_tf_ser_desc, wms_tf_ser_status, wms_tf_ser_valid_from, wms_tf_ser_valid_to, wms_tf_ser_service_period, wms_tf_ser_uom, wms_tf_ser_service_level_per, wms_tf_ser_reason_code, wms_tf_ser_timestamp, wms_tf_ser_created_by, wms_tf_ser_created_dt, wms_tf_ser_modified_by, wms_tf_ser_modified_dt, etlcreateddatetime
    FROM stg.stg_wms_tariff_service_hdr;
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