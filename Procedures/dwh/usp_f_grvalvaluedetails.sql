-- PROCEDURE: dwh.usp_f_grvalvaluedetails(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_grvalvaluedetails(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_grvalvaluedetails(
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
    FROM stg.stg_gr_val_valuedetails;

    UPDATE dwh.F_grvalvaluedetails t
    SET
        gr_val_ouinstid               = s.gr_val_ouinstid,
        gr_val_grno                   = s.gr_val_grno,
        gr_val_grlineno               = s.gr_val_grlineno,
        gr_val_cost                   = s.gr_val_cost,
        gr_val_costper                = s.gr_val_costper,
        gr_val_stdcost                = s.gr_val_stdcost,
        gr_val_accunit                = s.gr_val_accunit,
        gr_val_acusage                = s.gr_val_acusage,
        gr_val_linetcdvalue           = s.gr_val_linetcdvalue,
        gr_val_lineotcdvalue          = s.gr_val_lineotcdvalue,
        gr_val_doctcdstkvalue         = s.gr_val_doctcdstkvalue,
        gr_val_linetcdstkvalue        = s.gr_val_linetcdstkvalue,
        gr_val_createdby              = s.gr_val_createdby,
        gr_val_createdate             = s.gr_val_createdate,
        gr_val_modifiedby             = s.gr_val_modifiedby,
        gr_val_modifieddate           = s.gr_val_modifieddate,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_gr_val_valuedetails s
    WHERE t.gr_val_ouinstid = s.gr_val_ouinstid
    AND t.gr_val_grno = s.gr_val_grno
    AND t.gr_val_grlineno = s.gr_val_grlineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_grvalvaluedetails
    (
        gr_val_ouinstid, gr_val_grno, gr_val_grlineno, gr_val_cost, gr_val_costper, gr_val_stdcost, gr_val_accunit, gr_val_acusage, gr_val_linetcdvalue, gr_val_lineotcdvalue, gr_val_doctcdstkvalue, gr_val_linetcdstkvalue, gr_val_createdby, gr_val_createdate, gr_val_modifiedby, gr_val_modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.gr_val_ouinstid, s.gr_val_grno, s.gr_val_grlineno, s.gr_val_cost, s.gr_val_costper, s.gr_val_stdcost, s.gr_val_accunit, s.gr_val_acusage, s.gr_val_linetcdvalue, s.gr_val_lineotcdvalue, s.gr_val_doctcdstkvalue, s.gr_val_linetcdstkvalue, s.gr_val_createdby, s.gr_val_createdate, s.gr_val_modifiedby, s.gr_val_modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_gr_val_valuedetails s
    LEFT JOIN dwh.F_grvalvaluedetails t
    ON s.gr_val_ouinstid = t.gr_val_ouinstid
    AND s.gr_val_grno = t.gr_val_grno
    AND s.gr_val_grlineno = t.gr_val_grlineno
    WHERE t.gr_val_ouinstid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_gr_val_valuedetails
    (
        gr_val_ouinstid, gr_val_grno, gr_val_grlineno, gr_val_cost, gr_val_costper, gr_val_stdcost, gr_val_accunit, gr_val_acusage, gr_val_analycode, gr_val_sanalycode, gr_val_linetcdvalue, gr_val_lineotcdvalue, gr_val_doctcdstkvalue, gr_val_linetcdstkvalue, gr_val_createdby, gr_val_createdate, gr_val_modifiedby, gr_val_modifieddate, etlcreateddatetime
    )
    SELECT
        gr_val_ouinstid, gr_val_grno, gr_val_grlineno, gr_val_cost, gr_val_costper, gr_val_stdcost, gr_val_accunit, gr_val_acusage, gr_val_analycode, gr_val_sanalycode, gr_val_linetcdvalue, gr_val_lineotcdvalue, gr_val_doctcdstkvalue, gr_val_linetcdstkvalue, gr_val_createdby, gr_val_createdate, gr_val_modifiedby, gr_val_modifieddate, etlcreateddatetime
    FROM stg.stg_gr_val_valuedetails;
    
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
ALTER PROCEDURE dwh.usp_f_grvalvaluedetails(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
