-- PROCEDURE: dwh.usp_f_amiginitialbalance(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_amiginitialbalance(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_amiginitialbalance(
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
    FROM stg.Stg_amig_initial_balance;

    UPDATE dwh.F_amiginitialbalance t
    SET
        ou_id                  = s.ou_id,
        depr_book              = s.depr_book,
        fin_year               = s.fin_year,
        fin_period             = s.fin_period,
        asset_number           = s.asset_number,
        tag_number             = s.tag_number,
        fb_id                  = s.fb_id,
        asset_class            = s.asset_class,
        asset_cost             = s.asset_cost,
        cum_depr_charge        = s.cum_depr_charge,
        asset_book_val         = s.asset_book_val,
        complete_status        = s.complete_status,
        createdby              = s.createdby,
        createddate            = s.createddate,
        modifiedby             = s.modifiedby,
        modifieddate           = s.modifieddate,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.Stg_amig_initial_balance s
    WHERE t.ou_id = s.ou_id
    AND t.depr_book = s.depr_book
    AND t.fin_year = s.fin_year
    AND t.fin_period = s.fin_period
    AND t.asset_number = s.asset_number
    AND t.tag_number = s.tag_number
    AND t.fb_id = s.fb_id
    AND t.asset_class = s.asset_class;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_amiginitialbalance
    (
        ou_id, depr_book, fin_year, fin_period, asset_number, tag_number, fb_id, asset_class, asset_cost, cum_depr_charge, asset_book_val, complete_status, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.ou_id, s.depr_book, s.fin_year, s.fin_period, s.asset_number, s.tag_number, s.fb_id, s.asset_class, s.asset_cost, s.cum_depr_charge, s.asset_book_val, s.complete_status, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_amig_initial_balance s
    LEFT JOIN dwh.F_amiginitialbalance t
    ON s.ou_id = t.ou_id
    AND s.depr_book = t.depr_book
    AND s.fin_year = t.fin_year
    AND s.fin_period = t.fin_period
    AND s.asset_number = t.asset_number
    AND s.tag_number = t.tag_number
    AND s.fb_id = t.fb_id
    AND s.asset_class = t.asset_class
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_amig_initial_balance
    (
        ou_id, depr_book, fin_year, fin_period, asset_number, tag_number, fb_id, asset_class, timestamp, asset_cost, depr_charge, cum_depr_charge, reval_type, reval_date, reval_amount, rev_dep_cost, asset_book_val, complete_status, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        ou_id, depr_book, fin_year, fin_period, asset_number, tag_number, fb_id, asset_class, timestamp, asset_cost, depr_charge, cum_depr_charge, reval_type, reval_date, reval_amount, rev_dep_cost, asset_book_val, complete_status, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.Stg_amig_initial_balance;
    
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
ALTER PROCEDURE dwh.usp_f_amiginitialbalance(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
