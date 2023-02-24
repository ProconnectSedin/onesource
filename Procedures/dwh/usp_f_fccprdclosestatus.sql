-- PROCEDURE: dwh.usp_f_fccprdclosestatus(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_fccprdclosestatus(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_fccprdclosestatus(
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
    FROM stg.stg_fcc_prd_close_status;

    UPDATE dwh.F_fccprdclosestatus t
    SET
		fccstatus_companykey	  = COALESCE(c.company_key,-1),
        run_no                    = s.run_no,
        company_code              = s.company_code,
        fb_id                     = s.fb_id,
        fin_year                  = s.fin_year,
        fin_period                = s.fin_period,
        ou_id                     = s.ou_id,
        status                    = s.status,
        sequenceno                = s.sequenceno,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        fcc_finprd_startdt        = s.fcc_finprd_startdt,
        fcc_finprd_enddt          = s.fcc_finprd_enddt,
        fcc_finyr_startdt         = s.fcc_finyr_startdt,
        fcc_finyr_enddt           = s.fcc_finyr_enddt,
        fcc_finyr_range           = s.fcc_finyr_range,
        fcc_finprd_range          = s.fcc_finprd_range,
        ari_flag                  = s.ari_flag,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_fcc_prd_close_status s
	LEFT JOIN dwh.d_company c     
    ON s.company_code  = c.company_code 
    WHERE t.company_code = s.company_code
    AND t.fb_id = s.fb_id
    AND t.fin_year = s.fin_year
    AND t.fin_period = s.fin_period;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_fccprdclosestatus
    (
       fccstatus_companykey, run_no, company_code, fb_id, fin_year, fin_period, ou_id, status, sequenceno, createdby, createddate, fcc_finprd_startdt, fcc_finprd_enddt, fcc_finyr_startdt, fcc_finyr_enddt, fcc_finyr_range, fcc_finprd_range, ari_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(c.company_key,-1), s.run_no, s.company_code, s.fb_id, s.fin_year, s.fin_period, s.ou_id, s.status, s.sequenceno, s.createdby, s.createddate, s.fcc_finprd_startdt, s.fcc_finprd_enddt, s.fcc_finyr_startdt, s.fcc_finyr_enddt, s.fcc_finyr_range, s.fcc_finprd_range, s.ari_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_fcc_prd_close_status s
	LEFT JOIN dwh.d_company c     
    ON s.company_code  = c.company_code 	
    LEFT JOIN dwh.F_fccprdclosestatus t
    ON s.company_code = t.company_code
    AND s.fb_id = t.fb_id
    AND s.fin_year = t.fin_year
    AND s.fin_period = t.fin_period
    WHERE t.run_no IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_fcc_prd_close_status
    (
        run_no, company_code, fb_id, fin_year, fin_period, timestamp, ou_id, status, closed_by, closed_date, sequenceno, createdby, createddate, modifiedby, modifieddate, fcc_finprd_startdt, fcc_finprd_enddt, fcc_finyr_startdt, fcc_finyr_enddt, fcc_finyr_range, fcc_finprd_range, ari_flag, etlcreateddatetime
    )
    SELECT
        run_no, company_code, fb_id, fin_year, fin_period, timestamp, ou_id, status, closed_by, closed_date, sequenceno, createdby, createddate, modifiedby, modifieddate, fcc_finprd_startdt, fcc_finprd_enddt, fcc_finyr_startdt, fcc_finyr_enddt, fcc_finyr_range, fcc_finprd_range, ari_flag, etlcreateddatetime
    FROM stg.stg_fcc_prd_close_status;
    
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
ALTER PROCEDURE dwh.usp_f_fccprdclosestatus(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
