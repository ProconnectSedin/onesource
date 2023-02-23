-- PROCEDURE: dwh.usp_d_crdpuraddlndtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_crdpuraddlndtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_crdpuraddlndtl(
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
    FROM stg.stg_crd_pur_addln_dtl;

    UPDATE dwh.d_crdpuraddlndtl t
    SET
        event                      = s.event,
        finance_book               = s.finance_book,
        effective_from_date        = s.effective_from_date,
        supplier_group             = s.supplier_group,
        supplier_code              = s.supplier_code,
        receipt_at                 = s.receipt_at,
        number_series              = s.number_series,
        item_group                 = s.item_group,
        item_variant               = s.item_variant,
        folder                     = s.folder,
        ma_createdby               = s.ma_createdby,
        ma_createddate             = s.ma_createddate,
        ma_timestamp               = s.ma_timestamp,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_crd_pur_addln_dtl s
    WHERE s.bu_id		= t.bu_id
	AND s.ou_id			= t.ou_id
	AND s.company_code	= t.company_code
	AND s.account_code	= t.account_code
	AND s.usage_id		= t.usage_id
	AND s.cost_center	= t.cost_center
	AND s.item_code		= t.item_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_crdpuraddlndtl
    (
        bu_id, ou_id, company_code, event, finance_book, account_code, usage_id, effective_from_date, supplier_group, supplier_code, receipt_at, number_series, item_group, item_code, item_variant, folder, cost_center, ma_createdby, ma_createddate, ma_timestamp, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.bu_id, s.ou_id, s.company_code, s.event, s.finance_book, s.account_code, s.usage_id, s.effective_from_date, s.supplier_group, s.supplier_code, s.receipt_at, s.number_series, s.item_group, s.item_code, s.item_variant, s.folder, s.cost_center, s.ma_createdby, s.ma_createddate, s.ma_timestamp, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_crd_pur_addln_dtl s
    LEFT JOIN dwh.D_crdpuraddlndtl t
    ON  s.bu_id			= t.bu_id
	AND s.ou_id			= t.ou_id
	AND s.company_code	= t.company_code
	AND s.account_code	= t.account_code
	AND s.usage_id		= t.usage_id
	AND s.cost_center	= t.cost_center
	AND s.item_code		= t.item_code
    WHERE t.bu_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_crd_pur_addln_dtl
    (
        bu_id, ou_id, company_code, event, finance_book, account_code, usage_id, effective_from_date, supplier_group, supplier_code, receipt_at, number_series, item_group, item_code, item_variant, folder, cost_center, effective_to_date, ma_createdby, ma_createddate, ma_modifiedby, ma_modifieddate, ma_timestamp, etlcreateddatetime
    )
    SELECT
        bu_id, ou_id, company_code, event, finance_book, account_code, usage_id, effective_from_date, supplier_group, supplier_code, receipt_at, number_series, item_group, item_code, item_variant, folder, cost_center, effective_to_date, ma_createdby, ma_createddate, ma_modifiedby, ma_modifieddate, ma_timestamp, etlcreateddatetime
    FROM stg.stg_crd_pur_addln_dtl;
    
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
ALTER PROCEDURE dwh.usp_d_crdpuraddlndtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
