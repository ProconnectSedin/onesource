-- PROCEDURE: dwh.usp_f_tcaltaxhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tcaltaxhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tcaltaxhdr(
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
    FROM stg.stg_tcal_tax_hdr;

    UPDATE dwh.f_tcaltaxhdr t
    SET
        tran_no                        = s.tran_no,
        tax_type                       = s.tax_type,
        tran_type                      = s.tran_type,
        tran_ou                        = s.tran_ou,
        tran_line_no                   = s.tran_line_no,
        own_tax_region                 = s.own_tax_region,
        own_regd_no                    = s.own_regd_no,
        party_tax_region               = s.party_tax_region,
        party_regd_no                  = s.party_regd_no,
        decl_tax_region                = s.decl_tax_region,
        tax_category                   = s.tax_category,
        tax_class                      = s.tax_class,
        tax_register                   = s.tax_register,
        tax_reference                  = s.tax_reference,
        ref_doc_type                   = s.ref_doc_type,
        ref_doc_no                     = s.ref_doc_no,
        ref_doc_ou                     = s.ref_doc_ou,
        item_tc_type                   = s.item_tc_type,
        item_tc_usage_id               = s.item_tc_usage_id,
        item_tc_variant                = s.item_tc_variant,
        distrib_charge                 = s.distrib_charge,
        distrib_disc                   = s.distrib_disc,
        tax_uom                        = s.tax_uom,
        quantity                       = s.quantity,
        basic_amt                      = s.basic_amt,
        stat_tax                       = s.stat_tax,
        tc_amt                         = s.tc_amt,
        disc_amt                       = s.disc_amt,
        taxable_amt                    = s.taxable_amt,
        taxable_perc                   = s.taxable_perc,
        nontax_tc_amt                  = s.nontax_tc_amt,
        nontax_disc_amt                = s.nontax_disc_amt,
        comp_tax_amt                   = s.comp_tax_amt,
        corr_tax_amt                   = s.corr_tax_amt,
        comp_tax_amt_bascurr           = s.comp_tax_amt_bascurr,
        corr_tax_amt_bascurr           = s.corr_tax_amt_bascurr,
        ded_tax_amt                    = s.ded_tax_amt,
        ded_tax_amt_bascurr            = s.ded_tax_amt_bascurr,
        dr_cr_flag                     = s.dr_cr_flag,
        created_by                     = s.created_by,
        created_date                   = s.created_date,
        modified_by                    = s.modified_by,
        modified_date                  = s.modified_date,
        tax_excl_amt                   = s.tax_excl_amt,
        tax_incl_amt                   = s.tax_incl_amt,
        ref_doc_line_no                = s.ref_doc_line_no,
        tax_community                  = s.tax_community,
        taxable_amt_base               = s.taxable_amt_base,
        warehouse                      = s.warehouse,
        tds_tran_amt                   = s.tds_tran_amt,
        con_ref_doc_no                 = s.con_ref_doc_no,
        con_ref_doc_ou                 = s.con_ref_doc_ou,
        con_ref_doc_type               = s.con_ref_doc_type,
        weightage_factor               = s.weightage_factor,
        ship_to_id                     = s.ship_to_id,
        src_location_code              = s.src_location_code,
        des_location_code              = s.des_location_code,
        sec_heading                    = s.sec_heading,
        sub_heading                    = s.sub_heading,
        shipto_statecode               = s.shipto_statecode,
        billto_statecode               = s.billto_statecode,
        shipto_country                 = s.shipto_country,
        billto_country                 = s.billto_country,
        cp_return_frequency            = s.cp_return_frequency,
        claim_refund_flag              = s.claim_refund_flag,
        prov_itc_flag                  = s.prov_itc_flag,
        pos_state_code                 = s.pos_state_code,
        rev_charge_flag                = s.rev_charge_flag,
        ret1_new_classification        = s.ret1_new_classification,
        sec7act                        = s.sec7act,
        ref_doc_date                   = s.ref_doc_date,
        invoice_type                   = s.invoice_type,
        trans_mode                     = s.trans_mode,
        sub_supply_type                = s.sub_supply_type,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_tcal_tax_hdr s
    WHERE t.tran_no = s.tran_no
    AND t.tax_type = s.tax_type
    AND t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_line_no = s.tran_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_tcaltaxhdr
    (
        tran_no, tax_type, tran_type, tran_ou, tran_line_no, own_tax_region, own_regd_no, party_tax_region, party_regd_no, decl_tax_region, tax_category, tax_class, tax_register, tax_reference, ref_doc_type, ref_doc_no, ref_doc_ou, item_tc_type, item_tc_usage_id, item_tc_variant, distrib_charge, distrib_disc, tax_uom, quantity, basic_amt, stat_tax, tc_amt, disc_amt, taxable_amt, taxable_perc, nontax_tc_amt, nontax_disc_amt, comp_tax_amt, corr_tax_amt, comp_tax_amt_bascurr, corr_tax_amt_bascurr, ded_tax_amt, ded_tax_amt_bascurr, dr_cr_flag, created_by, created_date, modified_by, modified_date, tax_excl_amt, tax_incl_amt, ref_doc_line_no, tax_community, taxable_amt_base, warehouse, tds_tran_amt, con_ref_doc_no, con_ref_doc_ou, con_ref_doc_type, weightage_factor, ship_to_id, src_location_code, des_location_code, sec_heading, sub_heading, shipto_statecode, billto_statecode, shipto_country, billto_country, cp_return_frequency, claim_refund_flag, prov_itc_flag, pos_state_code, rev_charge_flag, ret1_new_classification, sec7act, ref_doc_date, invoice_type, trans_mode, sub_supply_type, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_no, s.tax_type, s.tran_type, s.tran_ou, s.tran_line_no, s.own_tax_region, s.own_regd_no, s.party_tax_region, s.party_regd_no, s.decl_tax_region, s.tax_category, s.tax_class, s.tax_register, s.tax_reference, s.ref_doc_type, s.ref_doc_no, s.ref_doc_ou, s.item_tc_type, s.item_tc_usage_id, s.item_tc_variant, s.distrib_charge, s.distrib_disc, s.tax_uom, s.quantity, s.basic_amt, s.stat_tax, s.tc_amt, s.disc_amt, s.taxable_amt, s.taxable_perc, s.nontax_tc_amt, s.nontax_disc_amt, s.comp_tax_amt, s.corr_tax_amt, s.comp_tax_amt_bascurr, s.corr_tax_amt_bascurr, s.ded_tax_amt, s.ded_tax_amt_bascurr, s.dr_cr_flag, s.created_by, s.created_date, s.modified_by, s.modified_date, s.tax_excl_amt, s.tax_incl_amt, s.ref_doc_line_no, s.tax_community, s.taxable_amt_base, s.warehouse, s.tds_tran_amt, s.con_ref_doc_no, s.con_ref_doc_ou, s.con_ref_doc_type, s.weightage_factor, s.ship_to_id, s.src_location_code, s.des_location_code, s.sec_heading, s.sub_heading, s.shipto_statecode, s.billto_statecode, s.shipto_country, s.billto_country, s.cp_return_frequency, s.claim_refund_flag, s.prov_itc_flag, s.pos_state_code, s.rev_charge_flag, s.ret1_new_classification, s.sec7act, s.ref_doc_date, s.invoice_type, s.trans_mode, s.sub_supply_type, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tcal_tax_hdr s
    LEFT JOIN dwh.f_tcaltaxhdr t
    ON s.tran_no = t.tran_no
    AND s.tax_type = t.tax_type
    AND s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_line_no = t.tran_line_no
    WHERE t.tran_no IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tcal_tax_hdr
    (
        tran_no, tax_type, tran_type, tran_ou, tran_line_no, own_tax_region, own_regd_no, party_tax_region, party_regd_no, decl_tax_region, tax_category, tax_class, tax_register, tax_reference, ref_doc_type, ref_doc_no, ref_doc_ou, item_tc_type, item_tc_usage_id, item_tc_variant, distrib_charge, distrib_disc, tax_uom, quantity, basic_amt, stat_tax, tc_amt, disc_amt, taxable_amt, taxable_perc, nontax_tc_amt, nontax_disc_amt, comp_tax_amt, corr_tax_amt, comp_tax_amt_bascurr, corr_tax_amt_bascurr, ded_tax_amt, ded_tax_amt_bascurr, dr_cr_flag, addnl_param1, addnl_param2, addnl_param3, addnl_param4, created_by, created_date, modified_by, modified_date, tax_excl_amt, tax_incl_amt, ref_doc_line_no, tax_community, taxable_amt_base, warehouse, tds_tran_amt, con_ref_doc_no, con_ref_doc_ou, con_ref_doc_type, weightage_factor, ttran_taxable_amt, ttran_tax_amt, ttran_taxable_bascur, ttran_tax_bascur, tax_amt_invoiced, processing_action, ship_to_id, ttran_tax_class, prop_wht_amt, app_wht_amt, tax_doc_type, tax_doc_no, no_of_inst, boe_no, boe_date, src_location_code, des_location_code, port_code, sec_heading, sub_heading, shipto_statecode, billto_statecode, shipto_country, billto_country, cp_return_frequency, claim_refund_flag, prov_itc_flag, pos_state_code, rev_charge_flag, ret1_new_classification, sec7act, ref_doc_date, invoice_type, trans_mode, sub_supply_type, etlcreatedatetime
    )
    SELECT
        tran_no, tax_type, tran_type, tran_ou, tran_line_no, own_tax_region, own_regd_no, party_tax_region, party_regd_no, decl_tax_region, tax_category, tax_class, tax_register, tax_reference, ref_doc_type, ref_doc_no, ref_doc_ou, item_tc_type, item_tc_usage_id, item_tc_variant, distrib_charge, distrib_disc, tax_uom, quantity, basic_amt, stat_tax, tc_amt, disc_amt, taxable_amt, taxable_perc, nontax_tc_amt, nontax_disc_amt, comp_tax_amt, corr_tax_amt, comp_tax_amt_bascurr, corr_tax_amt_bascurr, ded_tax_amt, ded_tax_amt_bascurr, dr_cr_flag, addnl_param1, addnl_param2, addnl_param3, addnl_param4, created_by, created_date, modified_by, modified_date, tax_excl_amt, tax_incl_amt, ref_doc_line_no, tax_community, taxable_amt_base, warehouse, tds_tran_amt, con_ref_doc_no, con_ref_doc_ou, con_ref_doc_type, weightage_factor, ttran_taxable_amt, ttran_tax_amt, ttran_taxable_bascur, ttran_tax_bascur, tax_amt_invoiced, processing_action, ship_to_id, ttran_tax_class, prop_wht_amt, app_wht_amt, tax_doc_type, tax_doc_no, no_of_inst, boe_no, boe_date, src_location_code, des_location_code, port_code, sec_heading, sub_heading, shipto_statecode, billto_statecode, shipto_country, billto_country, cp_return_frequency, claim_refund_flag, prov_itc_flag, pos_state_code, rev_charge_flag, ret1_new_classification, sec7act, ref_doc_date, invoice_type, trans_mode, sub_supply_type, etlcreatedatetime
    FROM stg.stg_tcal_tax_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_tcaltaxhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
