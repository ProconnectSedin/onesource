-- PROCEDURE: dwh.usp_f_grwmwhmove(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_grwmwhmove(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_grwmwhmove(
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
    FROM stg.stg_gr_wm_whmove;

    UPDATE dwh.F_grwmwhmove t
    SET
		gr_wm_whkey		  = coalesce(wh.wh_key,-1),
		gr_wm_uomkey		  = coalesce(u.uom_key,-1),
        gr_wm_ouinstid            = s.gr_wm_ouinstid,
        gr_wm_grno                = s.gr_wm_grno,
        gr_wm_grlineno            = s.gr_wm_grlineno,
        gr_wm_moveno              = s.gr_wm_moveno,
        gr_wm_status              = s.gr_wm_status,
        gr_wm_movedqty            = s.gr_wm_movedqty,
        gr_wm_whcode              = s.gr_wm_whcode,
        gr_wm_createdby           = s.gr_wm_createdby,
        gr_wm_createdate          = s.gr_wm_createdate,
        gr_wm_modifiedby          = s.gr_wm_modifiedby,
        gr_wm_modifieddate        = s.gr_wm_modifieddate,
        gr_wm_stkuom              = s.gr_wm_stkuom,
        gr_wm_convfact            = s.gr_wm_convfact,
        gr_wm_ordsubsch_no        = s.gr_wm_ordsubsch_no,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_gr_wm_whmove s
	left join dwh.d_warehouse wh
	ON wh.wh_code	=s.gr_wm_whcode
	left join dwh.d_uom u
	ON u.mas_uomcode=s.gr_wm_stkuom
    WHERE t.gr_wm_ouinstid = s.gr_wm_ouinstid
    AND t.gr_wm_grno = s.gr_wm_grno
    AND t.gr_wm_grlineno = s.gr_wm_grlineno
    AND t.gr_wm_moveno = s.gr_wm_moveno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_grwmwhmove
    (
     gr_wm_whkey,  gr_wm_uomkey, gr_wm_ouinstid, gr_wm_grno, gr_wm_grlineno, gr_wm_moveno, gr_wm_status, gr_wm_movedqty, gr_wm_whcode, gr_wm_createdby, gr_wm_createdate, gr_wm_modifiedby, gr_wm_modifieddate, gr_wm_stkuom, gr_wm_convfact, gr_wm_ordsubsch_no, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
      coalesce(wh.wh_key,-1), coalesce(u.uom_key,-1), s.gr_wm_ouinstid, s.gr_wm_grno, s.gr_wm_grlineno, s.gr_wm_moveno, s.gr_wm_status, s.gr_wm_movedqty, s.gr_wm_whcode, s.gr_wm_createdby, s.gr_wm_createdate, s.gr_wm_modifiedby, s.gr_wm_modifieddate, s.gr_wm_stkuom, s.gr_wm_convfact, s.gr_wm_ordsubsch_no, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_gr_wm_whmove s
	left join dwh.d_warehouse wh
	ON wh.wh_code	=s.gr_wm_whcode
	left join dwh.d_uom u
	ON u.mas_uomcode=s.gr_wm_stkuom	
    LEFT JOIN dwh.F_grwmwhmove t
    ON s.gr_wm_ouinstid = t.gr_wm_ouinstid
    AND s.gr_wm_grno = t.gr_wm_grno
    AND s.gr_wm_grlineno = t.gr_wm_grlineno
    AND s.gr_wm_moveno = t.gr_wm_moveno
    WHERE t.gr_wm_ouinstid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_gr_wm_whmove
    (
        gr_wm_ouinstid, gr_wm_grno, gr_wm_grlineno, gr_wm_moveno, gr_wm_status, gr_wm_movedqty, gr_wm_whcode, gr_wm_zone, gr_wm_bin, gr_wm_createdby, gr_wm_createdate, gr_wm_modifiedby, gr_wm_modifieddate, gr_wm_altuom, gr_wm_altqty, gr_wm_remarks, gr_wm_stkuom, gr_wm_convfact, gr_wm_ordsubsch_no, etlcreateddatetime
    )
    SELECT
        gr_wm_ouinstid, gr_wm_grno, gr_wm_grlineno, gr_wm_moveno, gr_wm_status, gr_wm_movedqty, gr_wm_whcode, gr_wm_zone, gr_wm_bin, gr_wm_createdby, gr_wm_createdate, gr_wm_modifiedby, gr_wm_modifieddate, gr_wm_altuom, gr_wm_altqty, gr_wm_remarks, gr_wm_stkuom, gr_wm_convfact, gr_wm_ordsubsch_no, etlcreateddatetime
    FROM stg.stg_gr_wm_whmove;
    
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
ALTER PROCEDURE dwh.usp_f_grwmwhmove(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
