-- PROCEDURE: dwh.usp_f_grsnoserialno(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_grsnoserialno(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_grsnoserialno(
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
    FROM stg.stg_gr_sno_serialno;

    UPDATE dwh.F_grsnoserialno t
    SET
        gr_sno_ouinstid            = s.gr_sno_ouinstid,
        gr_sno_grno                = s.gr_sno_grno,
        gr_sno_grlineno            = s.gr_sno_grlineno,
        gr_sno_lotno               = s.gr_sno_lotno,
        gr_sno_serialno            = s.gr_sno_serialno,
        gr_sno_suplotrefno         = s.gr_sno_suplotrefno,
        gr_sno_generatedby         = s.gr_sno_generatedby,
        gr_sno_createdby           = s.gr_sno_createdby,
        gr_sno_createdate          = s.gr_sno_createdate,
        gr_sno_modifiedby          = s.gr_sno_modifiedby,
        gr_sno_modifieddate        = s.gr_sno_modifieddate,
        gr_sno_altuom              = s.gr_sno_altuom,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_gr_sno_serialno s
    WHERE t.gr_sno_ouinstid = s.gr_sno_ouinstid
    AND t.gr_sno_grno = s.gr_sno_grno
    AND t.gr_sno_grlineno = s.gr_sno_grlineno
    AND t.gr_sno_lotno = s.gr_sno_lotno
    AND t.gr_sno_serialno = s.gr_sno_serialno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_grsnoserialno
    (
        gr_sno_ouinstid, gr_sno_grno, gr_sno_grlineno, gr_sno_lotno, gr_sno_serialno, gr_sno_suplotrefno, gr_sno_generatedby, gr_sno_createdby, gr_sno_createdate, gr_sno_modifiedby, gr_sno_modifieddate, gr_sno_altuom, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.gr_sno_ouinstid, s.gr_sno_grno, s.gr_sno_grlineno, s.gr_sno_lotno, s.gr_sno_serialno, s.gr_sno_suplotrefno, s.gr_sno_generatedby, s.gr_sno_createdby, s.gr_sno_createdate, s.gr_sno_modifiedby, s.gr_sno_modifieddate, s.gr_sno_altuom, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_gr_sno_serialno s
    LEFT JOIN dwh.F_grsnoserialno t
    ON s.gr_sno_ouinstid = t.gr_sno_ouinstid
    AND s.gr_sno_grno = t.gr_sno_grno
    AND s.gr_sno_grlineno = t.gr_sno_grlineno
    AND s.gr_sno_lotno = t.gr_sno_lotno
    AND s.gr_sno_serialno = t.gr_sno_serialno
    WHERE t.gr_sno_ouinstid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_gr_sno_serialno
    (
        gr_sno_ouinstid, gr_sno_grno, gr_sno_grlineno, gr_sno_lotno, gr_sno_serialno, gr_sno_suplotrefno, gr_sno_generatedby, gr_sno_createdby, gr_sno_createdate, gr_sno_modifiedby, gr_sno_modifieddate, gr_sno_altqty, gr_sno_altuom, etlcreateddatetime
    )
    SELECT
        gr_sno_ouinstid, gr_sno_grno, gr_sno_grlineno, gr_sno_lotno, gr_sno_serialno, gr_sno_suplotrefno, gr_sno_generatedby, gr_sno_createdby, gr_sno_createdate, gr_sno_modifiedby, gr_sno_modifieddate, gr_sno_altqty, gr_sno_altuom, etlcreateddatetime
    FROM stg.stg_gr_sno_serialno;
    
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
ALTER PROCEDURE dwh.usp_f_grsnoserialno(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
