-- PROCEDURE: dwh.usp_d_crdpurdefn(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_crdpurdefn(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_crdpurdefn(
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
    FROM stg.stg_crd_pur_defn;

    UPDATE dwh.d_crdpurdefn t
    SET
        event                      = s.event,
        effective_from_date        = s.effective_from_date,
        cost_center                = s.cost_center,
        effective_to_date          = s.effective_to_date,
        ma_createdby               = s.ma_createdby,
        ma_createddate             = s.ma_createddate,
        ma_modifiedby              = s.ma_modifiedby,
        ma_modifieddate            = s.ma_modifieddate,
        ma_timestamp               = s.ma_timestamp,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_crd_pur_defn s
    WHERE s.bu_id 		= t.bu_id
	AND s.ou_id 		= t.ou_id
	AND s.company_code 	= t.company_code
	AND s.finance_book 	= t.finance_book
	AND s.account_code 	= t.account_code
	AND s.addln_para_yn = t.addln_para_yn;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_crdpurdefn
    (
        bu_id				, ou_id			, company_code		, finance_book	, account_code	, event,
		effective_from_date	, cost_center	, effective_to_date	, addln_para_yn	, ma_createdby	, 
		ma_createddate		, ma_modifiedby	, ma_modifieddate	, ma_timestamp	,
		etlactiveind		, etljobname	, envsourcecd		, datasourcecd	, etlcreatedatetime
    )

    SELECT
        s.bu_id					, s.ou_id			, s.company_code		, s.finance_book	, s.account_code	, s.event,
		s.effective_from_date	, s.cost_center		, s.effective_to_date	, s.addln_para_yn	, s.ma_createdby	,
		s.ma_createddate		, s.ma_modifiedby	, s.ma_modifieddate		, s.ma_timestamp	,
					1			, p_etljobname		, p_envsourcecd			, p_datasourcecd	, NOW()
    FROM stg.stg_crd_pur_defn s
    LEFT JOIN dwh.D_crdpurdefn t
    ON s.bu_id 			= t.bu_id
	AND s.ou_id 		= t.ou_id
	AND s.company_code 	= t.company_code
	AND s.finance_book 	= t.finance_book
	AND s.account_code 	= t.account_code
	AND s.addln_para_yn = t.addln_para_yn
    WHERE t.bu_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_crd_pur_defn
    (
        bu_id, ou_id, company_code, finance_book, account_code, event, effective_from_date, cost_center, effective_to_date, addln_para_yn, ma_createdby, ma_createddate, ma_modifiedby, ma_modifieddate, ma_timestamp, etlcreateddatetime
    )
    SELECT
        bu_id, ou_id, company_code, finance_book, account_code, event, effective_from_date, cost_center, effective_to_date, addln_para_yn, ma_createdby, ma_createddate, ma_modifiedby, ma_modifieddate, ma_timestamp, etlcreateddatetime
    FROM stg.stg_crd_pur_defn;
    
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
ALTER PROCEDURE dwh.usp_d_crdpurdefn(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
