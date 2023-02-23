-- PROCEDURE: dwh.usp_d_emodcountrymst(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_emodcountrymst(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_emodcountrymst(
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
    FROM stg.stg_d_emodcountrymst;

    UPDATE dwh.d_emodcountrymst t
    SET
        country_code         = s.country_code,
        iso_curr_code        = s.iso_curr_code,
        timestamp            = s.timestamp,
        country_descr        = s.country_descr,
        modifiedby           = s.modifiedby,
        modifieddate         = s.modifieddate,
        etlactiveind         = 1,
        etljobname           = p_etljobname,
        envsourcecd          = p_envsourcecd,
        datasourcecd         = p_datasourcecd,
        etlupdatedatetime    = NOW()
    FROM stg.stg_d_emodcountrymst s
    WHERE t.country_code = s.country_code
    AND t.iso_curr_code = s.iso_curr_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_emodcountrymst
    (
        country_code, iso_curr_code, timestamp, country_descr, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.country_code, s.iso_curr_code, s.timestamp, s.country_descr, s.modifiedby, s.modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_d_emodcountrymst s
    LEFT JOIN dwh.D_emodcountrymst t
    ON s.country_code = t.country_code
    AND s.iso_curr_code = t.iso_curr_code
    WHERE t.country_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_emod_country_mst
    (
        country_code, iso_curr_code, timestamp, country_descr, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        country_code, iso_curr_code, timestamp, country_descr, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_d_emodcountrymst;
    
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
ALTER PROCEDURE dwh.usp_d_emodcountrymst(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
