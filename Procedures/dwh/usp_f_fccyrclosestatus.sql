-- PROCEDURE: dwh.usp_f_fccyrclosestatus(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_fccyrclosestatus(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_fccyrclosestatus(
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
    FROM stg.stg_fcc_yr_close_status;

    UPDATE dwh.F_fccyrclosestatus t
    SET
		fccyrclosestatus_companykey= COALESCE(c.company_key,-1),
        company_code             = s.company_code,
        fb_id                    = s.fb_id,
        fin_year                 = s.fin_year,
        ou_id                    = s.ou_id,
        status                   = s.status,
        closed_by                = s.closed_by,
        closed_date              = s.closed_date,
        createdby                = s.createdby,
        createddate              = s.createddate,
        fcc_finyr_startdt        = s.fcc_finyr_startdt,
        fcc_finyr_enddt          = s.fcc_finyr_enddt,
        fcc_finyr_range          = s.fcc_finyr_range,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_fcc_yr_close_status s
	LEFT JOIN dwh.d_company c     
    ON s.company_code  = c.company_code 	
    WHERE t.company_code = s.company_code
    AND t.fb_id = s.fb_id
    AND t.fin_year = s.fin_year;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_fccyrclosestatus
    (
     fccyrclosestatus_companykey ,  company_code, fb_id, fin_year, ou_id, status, closed_by, closed_date, createdby, createddate, fcc_finyr_startdt, fcc_finyr_enddt, fcc_finyr_range, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
     COALESCE(c.company_key,-1),   s.company_code, s.fb_id, s.fin_year, s.ou_id, s.status, s.closed_by, s.closed_date, s.createdby, s.createddate, s.fcc_finyr_startdt, s.fcc_finyr_enddt, s.fcc_finyr_range, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_fcc_yr_close_status s
	LEFT JOIN dwh.d_company c     
    ON s.company_code  = c.company_code 	
    LEFT JOIN dwh.F_fccyrclosestatus t
    ON s.company_code = t.company_code
    AND s.fb_id = t.fb_id
    AND s.fin_year = t.fin_year
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_fcc_yr_close_status
    (
        company_code, fb_id, fin_year, timestamp, ou_id, status, closed_by, closed_date, createdby, createddate, modifiedby, modifieddate, fcc_finyr_startdt, fcc_finyr_enddt, fcc_finyr_range, etlcreateddatetime
    )
    SELECT
        company_code, fb_id, fin_year, timestamp, ou_id, status, closed_by, closed_date, createdby, createddate, modifiedby, modifieddate, fcc_finyr_startdt, fcc_finyr_enddt, fcc_finyr_range, etlcreateddatetime
    FROM stg.stg_fcc_yr_close_status;
    
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
ALTER PROCEDURE dwh.usp_f_fccyrclosestatus(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
