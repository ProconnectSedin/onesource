-- PROCEDURE: dwh.usp_f_fchlocksettingsdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_fchlocksettingsdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_fchlocksettingsdtl(
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
    FROM stg.stg_fch_lock_settings_dtl;

    UPDATE dwh.F_fchlocksettingsdtl t
    SET
		fchlocksettingsdtl_cmpkey=COALESCE(c.company_key,-1),
        company_code           = s.company_code,
        guid                   = s.guid,
        fin_year_dtl           = s.fin_year_dtl,
        fin_period_dtl         = s.fin_period_dtl,
        bus_fnc_grp_dtl        = s.bus_fnc_grp_dtl,
        ou_id_dtl              = s.ou_id_dtl,
        fin_book_dtl           = s.fin_book_dtl,
        lock_flag              = s.lock_flag,
        excep_user_id          = s.excep_user_id,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_fch_lock_settings_dtl s
	LEFT JOIN dwh.d_company c     
    ON s.company_code  		= c.company_code 	
    WHERE t.company_code 	= s.company_code
    AND t.guid 			 	= s.guid
	AND t.bus_fnc_grp_dtl	=s.bus_fnc_grp_dtl
	AND t.fin_book_dtl 		=s.fin_book_dtl;
    GET DIAGNOSTICS updcnt = ROW_COUNT;
	

    INSERT INTO dwh.F_fchlocksettingsdtl
    (
      fchlocksettingsdtl_cmpkey,  company_code, guid, fin_year_dtl, fin_period_dtl, bus_fnc_grp_dtl, ou_id_dtl, fin_book_dtl, lock_flag, excep_user_id, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
     COALESCE(c.company_key,-1),   s.company_code, s.guid, s.fin_year_dtl, s.fin_period_dtl, s.bus_fnc_grp_dtl, s.ou_id_dtl, s.fin_book_dtl, s.lock_flag, s.excep_user_id, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_fch_lock_settings_dtl s
	LEFT JOIN dwh.d_company c     
    ON s.company_code  		= c.company_code 	
    LEFT JOIN dwh.F_fchlocksettingsdtl t
	ON  t.company_code 		= s.company_code
    AND t.guid 			 	= s.guid
	AND t.bus_fnc_grp_dtl	=s.bus_fnc_grp_dtl
	AND t.fin_book_dtl 		=s.fin_book_dtl
    WHERE t.company_code IS NULL;
	

	

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_fch_lock_settings_dtl
    (
        company_code, guid, fin_year_dtl, fin_period_dtl, bus_fnc_grp_dtl, ou_id_dtl, fin_book_dtl, lock_flag, excep_user_id, ml_flag, etlcreateddatetime
    )
    SELECT
        company_code, guid, fin_year_dtl, fin_period_dtl, bus_fnc_grp_dtl, ou_id_dtl, fin_book_dtl, lock_flag, excep_user_id, ml_flag, etlcreateddatetime
    FROM stg.stg_fch_lock_settings_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_fchlocksettingsdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
