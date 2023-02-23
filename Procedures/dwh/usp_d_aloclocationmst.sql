-- PROCEDURE: dwh.usp_d_aloclocationmst(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_aloclocationmst(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_aloclocationmst(
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
    FROM stg.stg_aloc_location_mst;

    UPDATE dwh.D_aloclocationmst t
    SET
        loc_code               = s.loc_code,
        timestamp              = s.timestamp,
        ou_id                  = s.ou_id,
        loc_desc               = s.loc_desc,
        loc_abbr               = s.loc_abbr,
        parentloc_code         = s.parentloc_code,
        loc_type               = s.loc_type,
        loc_status             = s.loc_status,
        createdby              = s.createdby,
        createddate            = s.createddate,
        modifiedby             = s.modifiedby,
        modifieddate           = s.modifieddate,
        workflow_status        = s.workflow_status,
        workflow_error         = s.workflow_error,
        wf_flag                = s.wf_flag,
        guid                   = s.guid,
        latitude               = s.latitude,
        longitude              = s.longitude,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_aloc_location_mst s
    WHERE t.loc_code = s.loc_code
    AND t.ou_id = s.ou_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_aloclocationmst
    (
        loc_code, timestamp, ou_id, loc_desc, loc_abbr, parentloc_code, loc_type, loc_status, createdby, createddate, modifiedby, modifieddate, workflow_status, workflow_error, wf_flag, guid, latitude, longitude, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.loc_code, s.timestamp, s.ou_id, s.loc_desc, s.loc_abbr, s.parentloc_code, s.loc_type, s.loc_status, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.workflow_status, s.workflow_error, s.wf_flag, s.guid, s.latitude, s.longitude, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_aloc_location_mst s
    LEFT JOIN dwh.D_aloclocationmst t
    ON s.loc_code = t.loc_code
    AND s.ou_id = t.ou_id
    WHERE t.loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_aloc_location_mst
    (
        loc_code, timestamp, ou_id, loc_desc, loc_abbr, parentloc_code, loc_type, loc_status, createdby, createddate, modifiedby, modifieddate, workflow_status, workflow_error, wf_flag, guid, latitude, longitude, etlcreateddatetime
    )
    SELECT
        loc_code, timestamp, ou_id, loc_desc, loc_abbr, parentloc_code, loc_type, loc_status, createdby, createddate, modifiedby, modifieddate, workflow_status, workflow_error, wf_flag, guid, latitude, longitude, etlcreateddatetime
    FROM stg.stg_aloc_location_mst;
    
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
ALTER PROCEDURE dwh.usp_d_aloclocationmst(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
