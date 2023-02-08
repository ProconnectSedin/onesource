CREATE TABLE IF NOT EXISTS "raw".raw_tcal_tax_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_no character varying(36) COLLATE public.nocase,
    tax_type character varying(50) COLLATE public.nocase,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_line_no integer,
    own_tax_region character varying(20) COLLATE public.nocase,
    own_regd_no character varying(80) COLLATE public.nocase,
    party_tax_region character varying(20) COLLATE public.nocase,
    party_regd_no character varying(80) COLLATE public.nocase,
    decl_tax_region character varying(20) COLLATE public.nocase,
    tax_category character varying(80) COLLATE public.nocase,
    tax_class character varying(80) COLLATE public.nocase,
    tax_register character varying(20) COLLATE public.nocase,
    tax_reference character varying(20) COLLATE public.nocase,
    ref_doc_type character varying(20) COLLATE public.nocase,
    ref_doc_no character varying(36) COLLATE public.nocase,
    ref_doc_ou integer,
    item_tc_type character varying(20) COLLATE public.nocase,
    item_tc_usage_id character varying(64) COLLATE public.nocase,
    item_tc_variant character varying(20) COLLATE public.nocase,
    distrib_charge numeric(13,2),
    distrib_disc numeric(13,2),
    tax_uom character varying(20) COLLATE public.nocase,
    quantity numeric(20,2),
    basic_amt numeric(20,2),
    stat_tax numeric(20,2),
    tc_amt numeric(20,2),
    disc_amt numeric(20,2),
    taxable_amt numeric(20,2),
    taxable_perc numeric(20,2),
    nontax_tc_amt numeric(20,2),
    nontax_disc_amt numeric(20,2),
    comp_tax_amt numeric(20,2),
    corr_tax_amt numeric(20,2),
    comp_tax_amt_bascurr numeric(20,2),
    corr_tax_amt_bascurr numeric(20,2),
    ded_tax_amt numeric(20,2),
    ded_tax_amt_bascurr numeric(20,2),
    dr_cr_flag character varying(20) COLLATE public.nocase,
    addnl_param1 integer,
    addnl_param2 integer,
    addnl_param3 integer,
    addnl_param4 integer,
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    tax_excl_amt numeric(20,2),
    tax_incl_amt numeric(20,2),
    ref_doc_line_no integer,
    tax_community character varying(50) COLLATE public.nocase,
    taxable_amt_base numeric(20,2),
    warehouse character varying(20) COLLATE public.nocase,
    tds_tran_amt numeric(20,2),
    con_ref_doc_no character varying(36) COLLATE public.nocase,
    con_ref_doc_ou integer,
    con_ref_doc_type character varying(20) COLLATE public.nocase,
    weightage_factor integer,
    ttran_taxable_amt numeric(20,8),
    ttran_tax_amt numeric(20,8),
    ttran_taxable_bascur numeric(20,8),
    ttran_tax_bascur numeric(20,8),
    tax_amt_invoiced numeric(20,8),
    processing_action character varying(16) COLLATE pg_catalog."default",
    ship_to_id character varying(20) COLLATE public.nocase,
    ttran_tax_class character varying(80) COLLATE pg_catalog."default",
    prop_wht_amt numeric(20,8),
    app_wht_amt numeric(20,8),
    tax_doc_type character varying(255) COLLATE pg_catalog."default",
    tax_doc_no character varying(36) COLLATE pg_catalog."default",
    no_of_inst integer,
    boe_no character varying(40) COLLATE pg_catalog."default",
    boe_date timestamp without time zone,
    src_location_code character varying(40) COLLATE public.nocase,
    des_location_code character varying(40) COLLATE public.nocase,
    port_code character varying(255) COLLATE pg_catalog."default",
    sec_heading character varying(50) COLLATE public.nocase,
    sub_heading character varying(50) COLLATE public.nocase,
    shipto_statecode character varying(24) COLLATE public.nocase,
    billto_statecode character varying(24) COLLATE public.nocase,
    shipto_country character varying(80) COLLATE public.nocase,
    billto_country character varying(80) COLLATE public.nocase,
    cp_return_frequency character varying(80) COLLATE public.nocase,
    claim_refund_flag character varying(80) COLLATE public.nocase,
    prov_itc_flag character varying(80) COLLATE public.nocase,
    pos_state_code character varying(510) COLLATE public.nocase,
    rev_charge_flag character varying(510) COLLATE public.nocase,
    ret1_new_classification character varying(80) COLLATE public.nocase,
    sec7act character varying(510) COLLATE public.nocase,
    ref_doc_date timestamp without time zone,
    invoice_type character varying(80) COLLATE public.nocase,
    trans_mode character varying(80) COLLATE public.nocase,
    sub_supply_type character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone
)
