-- PROCEDURE: dwh.usp_f_tstltaxhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tstltaxhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tstltaxhdr(
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
    FROM stg.stg_tstl_tax_hdr;

    UPDATE dwh.f_tstltaxhdr t
    SET
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
        item_value_bascurr             = s.item_value_bascurr,
        distr_tc_bascurr               = s.distr_tc_bascurr,
        distr_disc_bascurr             = s.distr_disc_bascurr,
        stat_tax_bascurr               = s.stat_tax_bascurr,
        tc_amt_bascurr                 = s.tc_amt_bascurr,
        disc_amt_bascurr               = s.disc_amt_bascurr,
        non_tax_base_tc                = s.non_tax_base_tc,
        non_tax_base_disc              = s.non_tax_base_disc,
        trade_type                     = s.trade_type,
        remit_due_date                 = s.remit_due_date,
        cert_gen_date                  = s.cert_gen_date,
        incorporation_date             = s.incorporation_date,
        decl_year                      = s.decl_year,
        decl_period                    = s.decl_period,
        created_by                     = s.created_by,
        created_date                   = s.created_date,
        modified_by                    = s.modified_by,
        modified_date                  = s.modified_date,
        Tax_Jv_no                      = s.Tax_Jv_no,
        tax_status                     = s.tax_status,
        weightage_factor               = s.weightage_factor,
        tax_incl_amount                = s.tax_incl_amount,
        tax_excl_amount                = s.tax_excl_amount,
        taxable_amt_bascur             = s.taxable_amt_bascur,
        tax_tran_date                  = s.tax_tran_date,
        tax_supp_cust_code             = s.tax_supp_cust_code,
        tax_party_type                 = s.tax_party_type,
        tax_assessee_type              = s.tax_assessee_type,
        tax_fbid                       = s.tax_fbid,
        refdoc_line_no                 = s.refdoc_line_no,
        dedtax_amt                     = s.dedtax_amt,
        dedtax_amt_bascurr             = s.dedtax_amt_bascurr,
        drcr_flag                      = s.drcr_flag,
        tax_exc_amt                    = s.tax_exc_amt,
        tax_inc_amt                    = s.tax_inc_amt,
        taxcommunity                   = s.taxcommunity,
        taxableamt_base                = s.taxableamt_base,
        ware_house                     = s.ware_house,
        tdstran_amt                    = s.tdstran_amt,
        conref_doc_no                  = s.conref_doc_no,
        conref_doc_ou                  = s.conref_doc_ou,
        conref_doc_type                = s.conref_doc_type,
        shipto_id                      = s.shipto_id,
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
        New_Return_Status              = s.New_Return_Status,
        ref_doc_date                   = s.ref_doc_date,
        invoice_type                   = s.invoice_type,
        sub_supply_type                = s.sub_supply_type,
        trans_mode                     = s.trans_mode,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_tstl_tax_hdr s
    WHERE t.tran_no = s.tran_no
    AND t.tax_type = s.tax_type
    AND t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_line_no = s.tran_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_tstltaxhdr
    (
        tran_no					, tax_type			, tran_type			, tran_ou			, tran_line_no, 
		own_tax_region			, own_regd_no		, party_tax_region	, party_regd_no		, decl_tax_region, 
		tax_category			, tax_class			, tax_register		, tax_reference		, ref_doc_type, 
		ref_doc_no				, ref_doc_ou		, item_tc_type		, item_tc_usage_id	, item_tc_variant,
		distrib_charge			, distrib_disc		, tax_uom			, quantity			, basic_amt, 
		stat_tax				, tc_amt			, disc_amt			, taxable_amt		, taxable_perc,
		nontax_tc_amt			, nontax_disc_amt	, comp_tax_amt		, corr_tax_amt		, comp_tax_amt_bascurr, 
		corr_tax_amt_bascurr	, item_value_bascurr, distr_tc_bascurr	, distr_disc_bascurr, stat_tax_bascurr,
		tc_amt_bascurr			, disc_amt_bascurr	, non_tax_base_tc	, non_tax_base_disc	, trade_type, 
		remit_due_date			, cert_gen_date		, incorporation_date, decl_year			, decl_period, 
		created_by				, created_date		, modified_by		, modified_date		, Tax_Jv_no, 
		tax_status				, weightage_factor	, tax_incl_amount	, tax_excl_amount	, taxable_amt_bascur, 
		tax_tran_date			, tax_supp_cust_code, tax_party_type	, tax_assessee_type	, tax_fbid, 
		refdoc_line_no			, dedtax_amt		, dedtax_amt_bascurr, drcr_flag			, tax_exc_amt, 
		tax_inc_amt				, taxcommunity		, taxableamt_base	, ware_house		, tdstran_amt, 
		conref_doc_no			, conref_doc_ou		, conref_doc_type	, shipto_id			, sec_heading,
		sub_heading				, shipto_statecode	, billto_statecode	, shipto_country	, billto_country, 
		cp_return_frequency		, claim_refund_flag	, prov_itc_flag		, pos_state_code	, rev_charge_flag,
		ret1_new_classification	, sec7act			, New_Return_Status	, ref_doc_date		, invoice_type,
		sub_supply_type			, trans_mode		,
		etlactiveind			, etljobname		, envsourcecd		, datasourcecd		, etlcreatedatetime
    )

    SELECT
        s.tran_no					, s.tax_type			, s.tran_type			, s.tran_ou				, s.tran_line_no,
		s.own_tax_region			, s.own_regd_no			, s.party_tax_region	, s.party_regd_no		, s.decl_tax_region, 
		s.tax_category				, s.tax_class			, s.tax_register		, s.tax_reference		, s.ref_doc_type,
		s.ref_doc_no				, s.ref_doc_ou			, s.item_tc_type		, s.item_tc_usage_id	, s.item_tc_variant, 
		s.distrib_charge			, s.distrib_disc		, s.tax_uom				, s.quantity			, s.basic_amt,
		s.stat_tax					, s.tc_amt				, s.disc_amt			, s.taxable_amt			, s.taxable_perc, 
		s.nontax_tc_amt				, s.nontax_disc_amt		, s.comp_tax_amt		, s.corr_tax_amt		, s.comp_tax_amt_bascurr,
		s.corr_tax_amt_bascurr		, s.item_value_bascurr	, s.distr_tc_bascurr	, s.distr_disc_bascurr	, s.stat_tax_bascurr,
		s.tc_amt_bascurr			, s.disc_amt_bascurr	, s.non_tax_base_tc		, s.non_tax_base_disc	, s.trade_type,
		s.remit_due_date			, s.cert_gen_date		, s.incorporation_date	, s.decl_year			, s.decl_period,
		s.created_by				, s.created_date		, s.modified_by			, s.modified_date		, s.Tax_Jv_no,
		s.tax_status				, s.weightage_factor	, s.tax_incl_amount		, s.tax_excl_amount		, s.taxable_amt_bascur,
		s.tax_tran_date				, s.tax_supp_cust_code	, s.tax_party_type		, s.tax_assessee_type	, s.tax_fbid,
		s.refdoc_line_no			, s.dedtax_amt			, s.dedtax_amt_bascurr	, s.drcr_flag			, s.tax_exc_amt, 
		s.tax_inc_amt				, s.taxcommunity		, s.taxableamt_base		, s.ware_house			, s.tdstran_amt,
		s.conref_doc_no				, s.conref_doc_ou		, s.conref_doc_type		, s.shipto_id			, s.sec_heading,
		s.sub_heading				, s.shipto_statecode	, s.billto_statecode	, s.shipto_country		, s.billto_country,
		s.cp_return_frequency		, s.claim_refund_flag	, s.prov_itc_flag		, s.pos_state_code		, s.rev_charge_flag,
		s.ret1_new_classification	, s.sec7act				, s.New_Return_Status	, s.ref_doc_date		, s.invoice_type,
		s.sub_supply_type			, s.trans_mode			,
						1			, p_etljobname			, p_envsourcecd			, p_datasourcecd		, NOW()
    FROM stg.stg_tstl_tax_hdr s
    LEFT JOIN dwh.f_tstltaxhdr t
    ON s.tran_no = t.tran_no
    AND s.tax_type = t.tax_type
    AND s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_line_no = t.tran_line_no
    WHERE t.tran_no IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tstl_tax_hdr
    (
        tran_no, tax_type, tran_type, tran_ou, tran_line_no, own_tax_region,
		own_regd_no, party_tax_region, party_regd_no, decl_tax_region, tax_category,
		tax_class, tax_register, tax_reference, ref_doc_type, ref_doc_no, ref_doc_ou,
		item_tc_type, item_tc_usage_id, item_tc_variant, distrib_charge, distrib_disc,
		tax_uom, quantity, basic_amt, stat_tax, tc_amt, disc_amt, taxable_amt,
		taxable_perc, nontax_tc_amt, nontax_disc_amt, comp_tax_amt, corr_tax_amt,
		comp_tax_amt_bascurr, corr_tax_amt_bascurr, item_value_bascurr, distr_tc_bascurr,
		distr_disc_bascurr, stat_tax_bascurr, tc_amt_bascurr, disc_amt_bascurr, 
		non_tax_base_tc, non_tax_base_disc, trade_type, remit_due_date, cert_gen_date,
		incorporation_date, decl_year, decl_period, addnl_param1, addnl_param2,
		addnl_param3, addnl_param4, created_by, created_date, modified_by, modified_date,
		Tax_Jv_no, tax_status, weightage_factor, tax_incl_amount, tax_excl_amount,
		taxable_amt_bascur, tax_tran_date, tax_supp_cust_code, tax_party_type, 
		tax_assessee_type, tax_fbid, refdoc_line_no, tax_doc_type, tax_doc_no, dedtax_amt,
		dedtax_amt_bascurr, drcr_flag, tax_exc_amt, tax_inc_amt, taxcommunity, 
		taxableamt_base, ware_house, tdstran_amt, conref_doc_no, conref_doc_ou, 
		conref_doc_type, ttrantaxable_amt, ttrantax_amt, ttrantaxable_bascur, 
		ttrantax_bascur, tax_amt_inv, proc_action, shipto_id, ttrantax_class, propwht_amt,
		appwht_amt, noofinst, boe_no, boe_date, adjusted_amount, port_code, filed_year,
		filed_period, sec_heading, sub_heading, shipto_statecode, billto_statecode,
		shipto_country, billto_country, recon_year, recon_period, recon_date, return_year,
		return_period, cp_return_frequency, claim_refund_flag, prov_itc_flag, pos_state_code,
		rev_charge_flag, ret1_new_classification, sec7act, New_Return_Status, ref_doc_date,
		invoice_type, sub_supply_type, trans_mode, etlcreatedatetime
    )
    SELECT
        tran_no, tax_type, tran_type, tran_ou, tran_line_no, own_tax_region,
		own_regd_no, party_tax_region, party_regd_no, decl_tax_region, tax_category,
		tax_class, tax_register, tax_reference, ref_doc_type, ref_doc_no, ref_doc_ou,
		item_tc_type, item_tc_usage_id, item_tc_variant, distrib_charge, distrib_disc,
		tax_uom, quantity, basic_amt, stat_tax, tc_amt, disc_amt, taxable_amt,
		taxable_perc, nontax_tc_amt, nontax_disc_amt, comp_tax_amt, corr_tax_amt,
		comp_tax_amt_bascurr, corr_tax_amt_bascurr, item_value_bascurr, distr_tc_bascurr,
		distr_disc_bascurr, stat_tax_bascurr, tc_amt_bascurr, disc_amt_bascurr, 
		non_tax_base_tc, non_tax_base_disc, trade_type, remit_due_date, cert_gen_date,
		incorporation_date, decl_year, decl_period, addnl_param1, addnl_param2,
		addnl_param3, addnl_param4, created_by, created_date, modified_by, modified_date,
		Tax_Jv_no, tax_status, weightage_factor, tax_incl_amount, tax_excl_amount,
		taxable_amt_bascur, tax_tran_date, tax_supp_cust_code, tax_party_type, 
		tax_assessee_type, tax_fbid, refdoc_line_no, tax_doc_type, tax_doc_no, dedtax_amt,
		dedtax_amt_bascurr, drcr_flag, tax_exc_amt, tax_inc_amt, taxcommunity, 
		taxableamt_base, ware_house, tdstran_amt, conref_doc_no, conref_doc_ou, 
		conref_doc_type, ttrantaxable_amt, ttrantax_amt, ttrantaxable_bascur, 
		ttrantax_bascur, tax_amt_inv, proc_action, shipto_id, ttrantax_class, propwht_amt,
		appwht_amt, noofinst, boe_no, boe_date, adjusted_amount, port_code, filed_year,
		filed_period, sec_heading, sub_heading, shipto_statecode, billto_statecode,
		shipto_country, billto_country, recon_year, recon_period, recon_date, return_year,
		return_period, cp_return_frequency, claim_refund_flag, prov_itc_flag, pos_state_code,
		rev_charge_flag, ret1_new_classification, sec7act, New_Return_Status, ref_doc_date,
		invoice_type, sub_supply_type, trans_mode, etlcreatedatetime
	FROM stg.stg_tstl_tax_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_tstltaxhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
