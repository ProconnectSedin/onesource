-- PROCEDURE: dwh.usp_f_griltitemlot(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_griltitemlot(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_griltitemlot(
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
    FROM stg.stg_gr_ilt_itemlot;

    UPDATE dwh.F_griltitemlot t
    SET
      
        gr_ilt_suplotrefno         = s.gr_ilt_suplotrefno,
        gr_ilt_quantity            = s.gr_ilt_quantity,
        gr_ilt_generatedby         = s.gr_ilt_generatedby,
        gr_ilt_createdby           = s.gr_ilt_createdby,
        gr_ilt_createdate          = s.gr_ilt_createdate,
        gr_ilt_modifiedby          = s.gr_ilt_modifiedby,
        gr_ilt_modifieddate        = s.gr_ilt_modifieddate,
        gr_ilt_moveno              = s.gr_ilt_moveno,
        gr_ilt_altqty              = s.gr_ilt_altqty,
        gr_ilt_altuom              = s.gr_ilt_altuom,
        gr_ilt_sublot_app          = s.gr_ilt_sublot_app,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_gr_ilt_itemlot s
    WHERE t.gr_ilt_ouinstid = s.gr_ilt_ouinstid
    AND t.gr_ilt_grno = s.gr_ilt_grno
    AND t.gr_ilt_grlineno = s.gr_ilt_grlineno
    AND t.gr_ilt_lotno = s.gr_ilt_lotno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_griltitemlot
    (
        gr_ilt_ouinstid, gr_ilt_grno, gr_ilt_grlineno, gr_ilt_lotno, gr_ilt_suplotrefno, gr_ilt_quantity, gr_ilt_generatedby, gr_ilt_createdby, gr_ilt_createdate, gr_ilt_modifiedby, gr_ilt_modifieddate, gr_ilt_moveno, gr_ilt_altqty, gr_ilt_altuom, gr_ilt_sublot_app, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.gr_ilt_ouinstid, s.gr_ilt_grno, s.gr_ilt_grlineno, s.gr_ilt_lotno, s.gr_ilt_suplotrefno, s.gr_ilt_quantity, s.gr_ilt_generatedby, s.gr_ilt_createdby, s.gr_ilt_createdate, s.gr_ilt_modifiedby, s.gr_ilt_modifieddate, s.gr_ilt_moveno, s.gr_ilt_altqty, s.gr_ilt_altuom, s.gr_ilt_sublot_app, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_gr_ilt_itemlot s
    LEFT JOIN dwh.F_griltitemlot t
    ON s.gr_ilt_ouinstid = t.gr_ilt_ouinstid
    AND s.gr_ilt_grno = t.gr_ilt_grno
    AND s.gr_ilt_grlineno = t.gr_ilt_grlineno
    AND s.gr_ilt_lotno = t.gr_ilt_lotno
    WHERE t.gr_ilt_ouinstid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_gr_ilt_itemlot
    (
        gr_ilt_ouinstid, gr_ilt_grno, gr_ilt_grlineno, gr_ilt_lotno, gr_ilt_suplotrefno, gr_ilt_quantity, gr_ilt_generatedby, gr_ilt_createdby, gr_ilt_createdate, gr_ilt_modifiedby, gr_ilt_modifieddate, gr_ilt_moveno, gr_ilt_altqty, gr_ilt_altuom, gr_ilt_sublot_app, etlcreateddatetime
    )
    SELECT
        gr_ilt_ouinstid, gr_ilt_grno, gr_ilt_grlineno, gr_ilt_lotno, gr_ilt_suplotrefno, gr_ilt_quantity, gr_ilt_generatedby, gr_ilt_createdby, gr_ilt_createdate, gr_ilt_modifiedby, gr_ilt_modifieddate, gr_ilt_moveno, gr_ilt_altqty, gr_ilt_altuom, gr_ilt_sublot_app, etlcreateddatetime
    FROM stg.stg_gr_ilt_itemlot;
    
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
ALTER PROCEDURE dwh.usp_f_griltitemlot(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
