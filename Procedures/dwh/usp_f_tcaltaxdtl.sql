-- PROCEDURE: dwh.usp_f_tcaltaxdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tcaltaxdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tcaltaxdtl(
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
    FROM stg.stg_tcal_tax_dtl;

    UPDATE dwh.F_TcalTaxdtl t
    SET
        tax_type                    = s.tax_type,
        tran_type                   = s.tran_type,
        tran_no                     = s.tran_no,
        tran_ou                     = s.tran_ou,
        tran_line_no                = s.tran_line_no,
        tax_line_no                 = s.tax_line_no,
        tax_code                    = s.tax_code,
        code_type                   = s.code_type,
        tax_rate                    = s.tax_rate,
        tax_basis                   = s.tax_basis,
        taxable_amt                 = s.taxable_amt,
        comp_tax_amt                = s.comp_tax_amt,
        corr_tax_amt                = s.corr_tax_amt,
        comp_tax_amt_bascurr        = s.comp_tax_amt_bascurr,
        corr_tax_amt_bascurr        = s.corr_tax_amt_bascurr,
        created_by                  = s.created_by,
        created_date                = s.created_date,
        modified_by                 = s.modified_by,
        modified_date               = s.modified_date,
        tax_group                   = s.tax_group,
        ref_doc_line_no             = s.ref_doc_line_no,
        taxable_amt_base            = s.taxable_amt_base,
        tax_community               = s.tax_community,
        commodity_code              = s.commodity_code,
        original_tax_code           = s.original_tax_code,
        original_tax_rate           = s.original_tax_rate,
        threshold_flag              = s.threshold_flag,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_tcal_tax_dtl s
    WHERE t.tax_type = s.tax_type
    AND t.tran_type = s.tran_type
    AND t.tran_no = s.tran_no
    AND t.tran_ou = s.tran_ou
    AND t.tran_line_no = s.tran_line_no
    AND t.tax_line_no = s.tax_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_tcaltaxdtl
    (
        tax_type, tran_type, tran_no, tran_ou, tran_line_no, tax_line_no, tax_code, code_type, tax_rate, tax_basis, taxable_amt, comp_tax_amt, corr_tax_amt, comp_tax_amt_bascurr, corr_tax_amt_bascurr, created_by, created_date, modified_by, modified_date, tax_group, ref_doc_line_no, taxable_amt_base, tax_community, commodity_code, original_tax_code, original_tax_rate, threshold_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tax_type, s.tran_type, s.tran_no, s.tran_ou, s.tran_line_no, s.tax_line_no, s.tax_code, s.code_type, s.tax_rate, s.tax_basis, s.taxable_amt, s.comp_tax_amt, s.corr_tax_amt, s.comp_tax_amt_bascurr, s.corr_tax_amt_bascurr, s.created_by, s.created_date, s.modified_by, s.modified_date, s.tax_group, s.ref_doc_line_no, s.taxable_amt_base, s.tax_community, s.commodity_code, s.original_tax_code, s.original_tax_rate, s.threshold_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tcal_tax_dtl s
    LEFT JOIN dwh.f_tcaltaxdtl t
    ON s.tax_type = t.tax_type
    AND s.tran_type = t.tran_type
    AND s.tran_no = t.tran_no
    AND s.tran_ou = t.tran_ou
    AND s.tran_line_no = t.tran_line_no
    AND s.tax_line_no = t.tax_line_no
    WHERE t.tax_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tcal_tax_dtl
    (
        tax_type, tran_type, tran_no, tran_ou, tran_line_no, tax_line_no, tax_code, code_type, tax_rate, tax_basis, taxable_amt, comp_tax_amt, corr_tax_amt, comp_tax_amt_bascurr, corr_tax_amt_bascurr, addnl_param1, addnl_param2, addnl_param3, addnl_param4, created_by, created_date, modified_by, modified_date, tax_group, ref_doc_line_no, taxable_amt_base, tax_community, ttran_taxable_amt, ttran_tax_amt, ttran_tax_code, ttran_tax_rate, ttran_taxable_amt_bascur, ttran_tax_amt_bascur, prop_wht_amt, app_wht_amt, commodity_code, original_tax_code, original_tax_rate, threshold_flag, taxable_amt_stcess, etlcreatedatetime
    )
    SELECT
        tax_type, tran_type, tran_no, tran_ou, tran_line_no, tax_line_no, tax_code, code_type, tax_rate, tax_basis, taxable_amt, comp_tax_amt, corr_tax_amt, comp_tax_amt_bascurr, corr_tax_amt_bascurr, addnl_param1, addnl_param2, addnl_param3, addnl_param4, created_by, created_date, modified_by, modified_date, tax_group, ref_doc_line_no, taxable_amt_base, tax_community, ttran_taxable_amt, ttran_tax_amt, ttran_tax_code, ttran_tax_rate, ttran_taxable_amt_bascur, ttran_tax_amt_bascur, prop_wht_amt, app_wht_amt, commodity_code, original_tax_code, original_tax_rate, threshold_flag, taxable_amt_stcess, etlcreatedatetime
    FROM stg.stg_tcal_tax_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_tcaltaxdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
