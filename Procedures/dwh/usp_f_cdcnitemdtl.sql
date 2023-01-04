-- PROCEDURE: dwh.usp_f_cdcnitemdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_cdcnitemdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_cdcnitemdtl(
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
    FROM stg.stg_cdcn_item_dtl;

    UPDATE dwh.F_cdcnitemdtl t
    SET
        visible_line_no         = s.visible_line_no,
        ref_doc_type            = s.ref_doc_type,
        ref_doc_no              = s.ref_doc_no,
        po_ou                   = s.po_ou,
        item_tcd_code           = s.item_tcd_code,
        item_tcd_var            = s.item_tcd_var,
        item_qty                = s.item_qty,
        unit_price              = s.unit_price,
        item_amount             = s.item_amount,
        remarks                 = s.remarks,
        tax_amount              = s.tax_amount,
        disc_amount             = s.disc_amount,
        line_amount             = s.line_amount,
        base_amount             = s.base_amount,
        par_base_amount         = s.par_base_amount,
        cost_center             = s.cost_center,
        analysis_code           = s.analysis_code,
        subanalysis_code        = s.subanalysis_code,
        createdby               = s.createdby,
        createddate             = s.createddate,
        modifiedby              = s.modifiedby,
        modifieddate            = s.modifieddate,
        ref_doc_line            = s.ref_doc_line,
        base_value              = s.base_value,
        ref_doc_date            = s.ref_doc_date,
        ccdesc                  = s.ccdesc,
        MAIL_SENT               = s.MAIL_SENT,
        own_tax_region          = s.own_tax_region,
        decl_tax_region         = s.decl_tax_region,
        party_tax_region        = s.party_tax_region,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_cdcn_item_dtl s
    WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.line_no = s.line_no
    AND t.timestamp = s.timestamp;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_cdcnitemdtl
    (
        tran_type, tran_ou, tran_no, line_no, timestamp, visible_line_no, ref_doc_type, ref_doc_no, po_ou, item_tcd_code, item_tcd_var, item_qty, unit_price, item_amount, remarks, tax_amount, disc_amount, line_amount, base_amount, par_base_amount, cost_center, analysis_code, subanalysis_code, createdby, createddate, modifiedby, modifieddate, ref_doc_line, base_value, ref_doc_date, ccdesc, MAIL_SENT, own_tax_region, decl_tax_region, party_tax_region, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_type, s.tran_ou, s.tran_no, s.line_no, s.timestamp, s.visible_line_no, s.ref_doc_type, s.ref_doc_no, s.po_ou, s.item_tcd_code, s.item_tcd_var, s.item_qty, s.unit_price, s.item_amount, s.remarks, s.tax_amount, s.disc_amount, s.line_amount, s.base_amount, s.par_base_amount, s.cost_center, s.analysis_code, s.subanalysis_code, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.ref_doc_line, s.base_value, s.ref_doc_date, s.ccdesc, s.MAIL_SENT, s.own_tax_region, s.decl_tax_region, s.party_tax_region, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_cdcn_item_dtl s
    LEFT JOIN dwh.F_cdcnitemdtl t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.line_no = t.line_no
    AND s.timestamp = t.timestamp
    WHERE t.tran_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cdcn_item_dtl
    (
        tran_type, tran_ou, tran_no, line_no, timestamp, visible_line_no, ref_doc_type, ref_doc_no, po_ou, item_tcd_code, item_tcd_var, item_qty, unit_price, item_amount, remarks, tax_amount, disc_amount, line_amount, base_amount, par_base_amount, cost_center, analysis_code, subanalysis_code, createdby, createddate, modifiedby, modifieddate, ref_doc_line, base_value, ref_doc_date, ccdesc, MAIL_SENT, own_tax_region, decl_tax_region, party_tax_region, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, line_no, timestamp, visible_line_no, ref_doc_type, ref_doc_no, po_ou, item_tcd_code, item_tcd_var, item_qty, unit_price, item_amount, remarks, tax_amount, disc_amount, line_amount, base_amount, par_base_amount, cost_center, analysis_code, subanalysis_code, createdby, createddate, modifiedby, modifieddate, ref_doc_line, base_value, ref_doc_date, ccdesc, MAIL_SENT, own_tax_region, decl_tax_region, party_tax_region, etlcreateddatetime
    FROM stg.stg_cdcn_item_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_cdcnitemdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
