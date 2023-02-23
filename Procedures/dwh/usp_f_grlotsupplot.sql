-- PROCEDURE: dwh.usp_f_grlotsupplot(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_grlotsupplot(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_grlotsupplot(
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
    FROM stg.stg_gr_lot_supplot;

    UPDATE dwh.F_grlotsupplot t
    SET
    
        gr_lot_lotno               = s.gr_lot_lotno,
        gr_lot_serialno            = s.gr_lot_serialno,
        gr_lot_mfrdate             = s.gr_lot_mfrdate,
        gr_lot_quantity            = s.gr_lot_quantity,
        gr_lot_createdby           = s.gr_lot_createdby,
        gr_lot_createdate          = s.gr_lot_createdate,
        gr_lot_modifiedby          = s.gr_lot_modifiedby,
        gr_lot_modifieddate        = s.gr_lot_modifieddate,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_gr_lot_supplot s
    WHERE t.gr_lot_ouinstid = s.gr_lot_ouinstid
    AND t.gr_lot_grno = s.gr_lot_grno
    AND t.gr_lot_grlineno = s.gr_lot_grlineno
    AND t.gr_lot_refno = s.gr_lot_refno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_grlotsupplot
    (
        gr_lot_ouinstid, gr_lot_grno, gr_lot_grlineno, gr_lot_refno, gr_lot_lotno, gr_lot_serialno, gr_lot_mfrdate, gr_lot_quantity, gr_lot_createdby, gr_lot_createdate, gr_lot_modifiedby, gr_lot_modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.gr_lot_ouinstid, s.gr_lot_grno, s.gr_lot_grlineno, s.gr_lot_refno, s.gr_lot_lotno, s.gr_lot_serialno, s.gr_lot_mfrdate, s.gr_lot_quantity, s.gr_lot_createdby, s.gr_lot_createdate, s.gr_lot_modifiedby, s.gr_lot_modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_gr_lot_supplot s
    LEFT JOIN dwh.F_grlotsupplot t
    ON s.gr_lot_ouinstid = t.gr_lot_ouinstid
    AND s.gr_lot_grno = t.gr_lot_grno
    AND s.gr_lot_grlineno = t.gr_lot_grlineno
    AND s.gr_lot_refno = t.gr_lot_refno
    WHERE t.gr_lot_ouinstid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_gr_lot_supplot
    (
        gr_lot_ouinstid, gr_lot_grno, gr_lot_grlineno, gr_lot_refno, gr_lot_lotno, gr_lot_sublotno, gr_lot_serialno, gr_lot_mfrdate, gr_lot_quantity, gr_lot_createdby, gr_lot_createdate, gr_lot_modifiedby, gr_lot_modifieddate, gr_lot_status, gr_lot_expdate, etlcreateddatetime
    )
    SELECT
        gr_lot_ouinstid, gr_lot_grno, gr_lot_grlineno, gr_lot_refno, gr_lot_lotno, gr_lot_sublotno, gr_lot_serialno, gr_lot_mfrdate, gr_lot_quantity, gr_lot_createdby, gr_lot_createdate, gr_lot_modifiedby, gr_lot_modifieddate, gr_lot_status, gr_lot_expdate, etlcreateddatetime
    FROM stg.stg_gr_lot_supplot;
    
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
ALTER PROCEDURE dwh.usp_f_grlotsupplot(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
