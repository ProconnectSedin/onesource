-- PROCEDURE: dwh.usp_d_tsettaxcategory(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_tsettaxcategory(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_tsettaxcategory(
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
    FROM stg.stg_TSET_TAX_CATEGORY;

    UPDATE dwh.D_TSETTAXCATEGORY t
    SET
        TAX_COMMUNITY            = s.TAX_COMMUNITY,
        TAX_TYPE                 = s.TAX_TYPE,
        COMPANY_CODE             = s.COMPANY_CODE,
        TAX_CATEGORY             = s.TAX_CATEGORY,
        TAX_CATEGORY_DESC        = s.TAX_CATEGORY_DESC,
        CALC_TAX                 = s.CALC_TAX,
        TRADE_TYPE               = s.TRADE_TYPE,
        STATUS                   = s.STATUS,
        PREDEFINED_TYPE          = s.PREDEFINED_TYPE,
        CREATED_AT               = s.CREATED_AT,
        CREATED_BY               = s.CREATED_BY,
        CREATED_DATE             = s.CREATED_DATE,
        MODIFIED_BY              = s.MODIFIED_BY,
        MODIFIED_DATE            = s.MODIFIED_DATE,
        TAX_CATEGORY_TYPE        = s.TAX_CATEGORY_TYPE,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_TSET_TAX_CATEGORY s
    WHERE t.TAX_COMMUNITY = s.TAX_COMMUNITY
    AND t.TAX_TYPE = s.TAX_TYPE
    AND t.COMPANY_CODE = s.COMPANY_CODE
    AND t.TAX_CATEGORY = s.TAX_CATEGORY
    AND t.TRADE_TYPE = s.TRADE_TYPE;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_TSETTAXCATEGORY
    (
        TAX_COMMUNITY, TAX_TYPE, COMPANY_CODE, TAX_CATEGORY, TAX_CATEGORY_DESC, CALC_TAX, TRADE_TYPE, STATUS, PREDEFINED_TYPE, CREATED_AT, CREATED_BY, CREATED_DATE, MODIFIED_BY, MODIFIED_DATE, TAX_CATEGORY_TYPE, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.TAX_COMMUNITY, s.TAX_TYPE, s.COMPANY_CODE, s.TAX_CATEGORY, s.TAX_CATEGORY_DESC, s.CALC_TAX, s.TRADE_TYPE, s.STATUS, s.PREDEFINED_TYPE, s.CREATED_AT, s.CREATED_BY, s.CREATED_DATE, s.MODIFIED_BY, s.MODIFIED_DATE, s.TAX_CATEGORY_TYPE, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_TSET_TAX_CATEGORY s
    LEFT JOIN dwh.D_TSETTAXCATEGORY t
    ON s.TAX_COMMUNITY = t.TAX_COMMUNITY
    AND s.TAX_TYPE = t.TAX_TYPE
    AND s.COMPANY_CODE = t.COMPANY_CODE
    AND s.TAX_CATEGORY = t.TAX_CATEGORY
    AND s.TRADE_TYPE = t.TRADE_TYPE
    WHERE t.TAX_COMMUNITY IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tset_tax_category
    (
        TAX_COMMUNITY, TAX_TYPE, COMPANY_CODE, TAX_CATEGORY, TAX_CATEGORY_DESC, CALC_TAX, TRADE_TYPE, STATUS, PREDEFINED_TYPE, CREATED_AT, CREATED_BY, CREATED_DATE, MODIFIED_BY, MODIFIED_DATE, TAX_CATEGORY_TYPE, etlcreateddatetime
    )
    SELECT
        TAX_COMMUNITY, TAX_TYPE, COMPANY_CODE, TAX_CATEGORY, TAX_CATEGORY_DESC, CALC_TAX, TRADE_TYPE, STATUS, PREDEFINED_TYPE, CREATED_AT, CREATED_BY, CREATED_DATE, MODIFIED_BY, MODIFIED_DATE, TAX_CATEGORY_TYPE, etlcreateddatetime
    FROM stg.stg_TSET_TAX_CATEGORY;
    
    END IF;
--     EXCEPTION WHEN others THEN
--         get stacked diagnostics
--             p_errorid   = returned_sqlstate,
--             p_errordesc = message_text;
--     CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
--        select 0 into inscnt;
--        select 0 into updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_d_tsettaxcategory(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
