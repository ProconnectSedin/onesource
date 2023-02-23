-- PROCEDURE: dwh.usp_f_grfinfinancepost(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_grfinfinancepost(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_grfinfinancepost(
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
    FROM stg.stg_gr_fin_financepost;

    UPDATE dwh.f_grfinfinancepost t
    SET
		grfinfinancepost_opcoa_key	   = COALESCE(ac.opcoa_key,-1),
        gr_fin_fbpou                   = s.gr_fin_fbpou,
        gr_fin_usageid                 = s.gr_fin_usageid,
        gr_fin_eventcode               = s.gr_fin_eventcode,
        gr_fin_accounttype             = s.gr_fin_accounttype,
        gr_fin_drcrflag                = s.gr_fin_drcrflag,
        gr_fin_accountcode             = s.gr_fin_accountcode,
        gr_fin_tranamount              = s.gr_fin_tranamount,
        gr_fin_baseamount              = s.gr_fin_baseamount,
        gr_fin_parbaseamount           = s.gr_fin_parbaseamount,
        gr_fin_createdby               = s.gr_fin_createdby,
        gr_fin_createddate             = s.gr_fin_createddate,
        gr_fin_modifiedby              = s.gr_fin_modifiedby,
        gr_fin_modifiedate             = s.gr_fin_modifiedate,
        gr_fin_remarks                 = s.gr_fin_remarks,
        gr_fin_costcenter              = s.gr_fin_costcenter,
        gr_fin_analysis_code           = s.gr_fin_analysis_code,
        gr_fin_sub_analysiscode        = s.gr_fin_sub_analysiscode,
        gr_fin_movelineno              = s.gr_fin_movelineno,
        gr_fin_fbid                    = s.gr_fin_fbid,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_gr_fin_financepost s
    LEFT JOIN dwh.d_operationalaccountdetail ac     
    ON 	  s.gr_fin_accountcode  			= ac.account_code
    WHERE t.gr_fin_ouinstid 		   = s.gr_fin_ouinstid
    AND   t.gr_fin_grno 			   = s.gr_fin_grno
    AND   t.gr_fin_grlineno 		   = s.gr_fin_grlineno
    AND   t.gr_fin_finlineno 		   = s.gr_fin_finlineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_grfinfinancepost
    (
		grfinfinancepost_opcoa_key,
        gr_fin_ouinstid, 		 gr_fin_grno, 		 gr_fin_grlineno, 	 	gr_fin_finlineno, 	gr_fin_fbpou, 
		gr_fin_usageid, 		 gr_fin_eventcode, 	 gr_fin_accounttype, 	gr_fin_drcrflag, 	gr_fin_accountcode, 
		gr_fin_tranamount, 		 gr_fin_baseamount,  gr_fin_parbaseamount, 	gr_fin_createdby, 	gr_fin_createddate, 
		gr_fin_modifiedby, 		 gr_fin_modifiedate, gr_fin_remarks, 		gr_fin_costcenter, 	gr_fin_analysis_code, 
		gr_fin_sub_analysiscode, gr_fin_movelineno,  gr_fin_fbid, 			etlactiveind, 		etljobname, 
		envsourcecd, 			 datasourcecd, 		 etlcreatedatetime
    )

    SELECT
		COALESCE(ac.opcoa_key,-1),
        s.gr_fin_ouinstid, 			s.gr_fin_grno, 			s.gr_fin_grlineno, 		s.gr_fin_finlineno, 	s.gr_fin_fbpou, 
		s.gr_fin_usageid, 			s.gr_fin_eventcode, 	s.gr_fin_accounttype, 	s.gr_fin_drcrflag, 		s.gr_fin_accountcode, 
		s.gr_fin_tranamount, 		s.gr_fin_baseamount, 	s.gr_fin_parbaseamount, s.gr_fin_createdby, 	s.gr_fin_createddate, 
		s.gr_fin_modifiedby, 		s.gr_fin_modifiedate, 	s.gr_fin_remarks, 		s.gr_fin_costcenter, 	s.gr_fin_analysis_code, 
		s.gr_fin_sub_analysiscode,  s.gr_fin_movelineno, 	s.gr_fin_fbid, 			1, 						p_etljobname, 
		p_envsourcecd, 				p_datasourcecd, 		NOW()
    FROM stg.stg_gr_fin_financepost s
    LEFT JOIN dwh.d_operationalaccountdetail ac     
    ON 	  s.gr_fin_accountcode  			= ac.account_code
    LEFT JOIN dwh.f_grfinfinancepost t
    ON  s.gr_fin_ouinstid 	= t.gr_fin_ouinstid
    AND s.gr_fin_grno 	  	= t.gr_fin_grno
    AND s.gr_fin_grlineno 	= t.gr_fin_grlineno
    AND s.gr_fin_finlineno 	= t.gr_fin_finlineno
    WHERE t.gr_fin_ouinstid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_gr_fin_financepost
    (
        gr_fin_ouinstid, 	gr_fin_grno, 		gr_fin_grlineno, 		gr_fin_finlineno, 		gr_fin_fbpou, 
		gr_fin_usageid, 	gr_fin_eventcode, 	gr_fin_accounttype, 	gr_fin_drcrflag, 		gr_fin_accountcode, 
		gr_fin_tranamount, 	gr_fin_baseamount, 	gr_fin_parbaseamount, 	gr_fin_plbasecurrency, 	gr_fin_plbexchgrate, 
		gr_fin_createdby, 	gr_fin_createddate, gr_fin_modifiedby, 		gr_fin_modifiedate, 	gr_fin_remarks, 
		gr_fin_projectcode, gr_fin_projectou, 	gr_fin_costcenter, 		gr_fin_analysis_code, 	gr_fin_sub_analysiscode, 
		gr_fin_movelineno, 	gr_fin_fbid, 		etlcreateddatetime
    )
    SELECT
		gr_fin_ouinstid, 	gr_fin_grno, 		gr_fin_grlineno, 		gr_fin_finlineno, 		gr_fin_fbpou, 
		gr_fin_usageid, 	gr_fin_eventcode, 	gr_fin_accounttype, 	gr_fin_drcrflag, 		gr_fin_accountcode, 
		gr_fin_tranamount, 	gr_fin_baseamount, 	gr_fin_parbaseamount, 	gr_fin_plbasecurrency, 	gr_fin_plbexchgrate, 
		gr_fin_createdby, 	gr_fin_createddate, gr_fin_modifiedby, 		gr_fin_modifiedate, 	gr_fin_remarks, 
		gr_fin_projectcode, gr_fin_projectou, 	gr_fin_costcenter, 		gr_fin_analysis_code, 	gr_fin_sub_analysiscode, 
		gr_fin_movelineno, 	gr_fin_fbid, 		etlcreateddatetime
    FROM stg.stg_gr_fin_financepost;
    
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
ALTER PROCEDURE dwh.usp_f_grfinfinancepost(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
