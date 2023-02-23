-- PROCEDURE: dwh.usp_f_grcpmconsmove(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_grcpmconsmove(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_grcpmconsmove(
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
    FROM stg.stg_gr_cpm_consmove;

    UPDATE dwh.f_grcpmconsmove t
    SET
        gr_cpm_status              = s.gr_cpm_status,
        gr_cpm_movedqty            = s.gr_cpm_movedqty,
        gr_cpm_ccusage             = s.gr_cpm_ccusage,
        gr_cpm_wotype              = s.gr_cpm_wotype,
        gr_cpm_createdby           = s.gr_cpm_createdby,
        gr_cpm_createdate          = s.gr_cpm_createdate,
        gr_cpm_modifiedby          = s.gr_cpm_modifiedby,
        gr_cpm_modifieddate        = s.gr_cpm_modifieddate,
        gr_cpm_acusage             = s.gr_cpm_acusage,
        gr_cpm_remarks             = s.gr_cpm_remarks,
        gr_cpm_ordsubsch_no        = s.gr_cpm_ordsubsch_no,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_gr_cpm_consmove s
    WHERE t.gr_cpm_ouinstid 	   = s.gr_cpm_ouinstid
    AND   t.gr_cpm_grno 		   = s.gr_cpm_grno
    AND   t.gr_cpm_grlineno 	   = s.gr_cpm_grlineno
    AND   t.gr_cpm_lineno 		   = s.gr_cpm_lineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_grcpmconsmove
    (
        gr_cpm_ouinstid, 		gr_cpm_grno, 			gr_cpm_grlineno, 	gr_cpm_lineno, 		gr_cpm_status, 
		gr_cpm_movedqty, 		gr_cpm_ccusage, 		gr_cpm_wotype, 		gr_cpm_createdby, 	gr_cpm_createdate, 
		gr_cpm_modifiedby, 		gr_cpm_modifieddate, 	gr_cpm_acusage, 	gr_cpm_remarks, 	gr_cpm_ordsubsch_no, 
		etlactiveind, 			etljobname, 			envsourcecd, 		datasourcecd, 		etlcreatedatetime
    )

    SELECT
        s.gr_cpm_ouinstid, 		s.gr_cpm_grno, 			s.gr_cpm_grlineno, 	s.gr_cpm_lineno, 	s.gr_cpm_status, 
		s.gr_cpm_movedqty, 		s.gr_cpm_ccusage, 		s.gr_cpm_wotype, 	s.gr_cpm_createdby, s.gr_cpm_createdate, 
		s.gr_cpm_modifiedby, 	s.gr_cpm_modifieddate, 	s.gr_cpm_acusage, 	s.gr_cpm_remarks, 	s.gr_cpm_ordsubsch_no, 
		1, 						p_etljobname, 			p_envsourcecd, 		p_datasourcecd, 	NOW()
    FROM stg.stg_gr_cpm_consmove s
    LEFT JOIN dwh.f_grcpmconsmove t
    ON  s.gr_cpm_ouinstid = t.gr_cpm_ouinstid
    AND s.gr_cpm_grno 	  = t.gr_cpm_grno
    AND s.gr_cpm_grlineno = t.gr_cpm_grlineno
    AND s.gr_cpm_lineno   = t.gr_cpm_lineno
    WHERE t.gr_cpm_ouinstid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_gr_cpm_consmove
    (
        gr_cpm_ouinstid, 		gr_cpm_grno, 		gr_cpm_grlineno, 		gr_cpm_lineno, 			gr_cpm_status, 
		gr_cpm_movedqty, 		gr_cpm_ccusage, 	gr_cpm_moveto, 			gr_cpm_wotype, 			gr_cpm_woorderno, 
		gr_cpm_woorderlineno, 	gr_cpm_createdby, 	gr_cpm_createdate, 		gr_cpm_modifiedby, 		gr_cpm_modifieddate, 
		gr_cpm_altuom, 			gr_cpm_altqty, 		gr_cpm_acusage, 		gr_cpm_analysiscode, 	gr_cpm_subanalysiscode, 
		gr_cpm_remarks, 		gr_cpm_costcenter, 	gr_cpm_ordsubsch_no, 	etlcreateddatetime
    )
    SELECT
        gr_cpm_ouinstid, 		gr_cpm_grno, 		gr_cpm_grlineno, 		gr_cpm_lineno, 			gr_cpm_status, 
		gr_cpm_movedqty, 		gr_cpm_ccusage, 	gr_cpm_moveto, 			gr_cpm_wotype, 			gr_cpm_woorderno, 
		gr_cpm_woorderlineno, 	gr_cpm_createdby, 	gr_cpm_createdate, 		gr_cpm_modifiedby, 		gr_cpm_modifieddate, 
		gr_cpm_altuom, 			gr_cpm_altqty, 		gr_cpm_acusage, 		gr_cpm_analysiscode, 	gr_cpm_subanalysiscode, 
		gr_cpm_remarks, 		gr_cpm_costcenter, 	gr_cpm_ordsubsch_no, 	etlcreateddatetime
    FROM stg.stg_gr_cpm_consmove;
    
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
ALTER PROCEDURE dwh.usp_f_grcpmconsmove(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
