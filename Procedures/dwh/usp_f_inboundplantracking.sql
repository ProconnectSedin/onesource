-- PROCEDURE: dwh.usp_f_inboundplantracking(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_inboundplantracking(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_inboundplantracking(
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
    FROM stg.stg_wms_inbound_pln_track_dtl;

    UPDATE dwh.F_InboundPlanTracking t
    SET
        pln_date_key        = COALESCE(d.datekey,-1),
        pln_stage             = s.wms_pln_stage,
        pln_pln_no            = s.wms_pln_pln_no,
        pln_exe_no            = s.wms_pln_exe_no,
        pln_exe_status        = s.wms_pln_exe_status,
        pln_user              = s.wms_pln_user,
        pln_date              = s.wms_pln_date,
        etlactiveind          = 1,
        etljobname            = p_etljobname,
        envsourcecd           = p_envsourcecd,
        datasourcecd          = p_datasourcecd,
        etlupdatedatetime     = NOW()
    FROM stg.stg_wms_inbound_pln_track_dtl s
    LEFT JOIN dwh.d_date D          
        ON s.wms_pln_date::date = D.dateactual

    WHERE t.pln_lineno = s.wms_pln_lineno
    AND t.pln_ou = s.wms_pln_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_InboundPlanTracking
    (
       pln_date_key, pln_lineno, pln_ou, pln_stage, pln_pln_no, pln_exe_no, pln_exe_status, pln_user, pln_date, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
          D.datekey ,s.wms_pln_lineno, s.wms_pln_ou, s.wms_pln_stage, s.wms_pln_pln_no, s.wms_pln_exe_no, s.wms_pln_exe_status, s.wms_pln_user, s.wms_pln_date, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_inbound_pln_track_dtl s

       LEFT JOIN dwh.d_date D          
        ON s.wms_pln_date::date = D.dateactual
        
    LEFT JOIN dwh.F_InboundPlanTracking t
    ON s.wms_pln_lineno = t.pln_lineno
    AND s.wms_pln_ou = t.pln_ou
    WHERE t.pln_lineno IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_inbound_pln_track_dtl
    (
        wms_pln_lineno, wms_pln_ou, wms_pln_stage, wms_pln_pln_no, wms_pln_exe_no, wms_pln_exe_status, wms_pln_user, wms_pln_date, etlcreateddatetime
    )
    SELECT
        wms_pln_lineno, wms_pln_ou, wms_pln_stage, wms_pln_pln_no, wms_pln_exe_no, wms_pln_exe_status, wms_pln_user, wms_pln_date, etlcreateddatetime
    FROM stg.stg_wms_inbound_pln_track_dtl;
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
ALTER PROCEDURE dwh.usp_f_inboundplantracking(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
