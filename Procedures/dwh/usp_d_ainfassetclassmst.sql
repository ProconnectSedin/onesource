-- PROCEDURE: dwh.usp_d_ainfassetclassmst(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_ainfassetclassmst(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_ainfassetclassmst(
	IN p_sourceid character varying,
	IN p_dataflowflag character varying,
	IN p_targetobject character varying,
	OUT srccnt integer,
	OUT inscnt integer,
	OUT updcnt integer,
	OUT dltcount integer,
	INOUT flag1 character varying,
	OUT flag2 character varying)
LANGUAGE 'plpgsql'
AS $BODY$

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
    FROM stg.stg_ainf_asset_class_mst;

    UPDATE dwh.D_ainfassetclassmst t
    SET
        asset_class_code          = s.asset_class_code,
        ou_id                     = s.ou_id,
        timestamp                 = s.timestamp,
        asset_class_desc          = s.asset_class_desc,
        depreciable               = s.depreciable,
        inv_cycle                 = s.inv_cycle,
        asset_class_status        = s.asset_class_status,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        asset_prefix              = s.asset_prefix,
        lastgenno                 = s.lastgenno,
        lease_asset               = s.lease_asset,
        land_info                 = s.land_info,
        residual_val              = s.residual_val,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_ainf_asset_class_mst s
    WHERE t.asset_class_code = s.asset_class_code
    AND t.ou_id = s.ou_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_ainfassetclassmst
    (
        asset_class_code, ou_id, timestamp, asset_class_desc, depreciable, inv_cycle, asset_class_status, createdby, createddate, modifiedby, modifieddate, asset_prefix, lastgenno, lease_asset, land_info, residual_val, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.asset_class_code, s.ou_id, s.timestamp, s.asset_class_desc, s.depreciable, s.inv_cycle, s.asset_class_status, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.asset_prefix, s.lastgenno, s.lease_asset, s.land_info, s.residual_val, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_ainf_asset_class_mst s
    LEFT JOIN dwh.D_ainfassetclassmst t
    ON s.asset_class_code = t.asset_class_code
    AND s.ou_id = t.ou_id
    WHERE t.asset_class_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ainf_asset_class_mst
    (
        asset_class_code, ou_id, timestamp, asset_class_desc, depreciable, inv_cycle, asset_class_status, createdby, createddate, modifiedby, modifieddate, asset_prefix, lastgenno, lease_asset, land_info, residual_val, etlcreateddatetime
    )
    SELECT
        asset_class_code, ou_id, timestamp, asset_class_desc, depreciable, inv_cycle, asset_class_status, createdby, createddate, modifiedby, modifieddate, asset_prefix, lastgenno, lease_asset, land_info, residual_val, etlcreateddatetime
    FROM stg.stg_ainf_asset_class_mst;
    
    END IF;
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_d_ainfassetclassmst(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
