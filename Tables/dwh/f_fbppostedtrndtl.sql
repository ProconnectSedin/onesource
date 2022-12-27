CREATE TABLE dwh.f_fbppostedtrndtl (
    fbp_trn_dtl_key bigint NOT NULL,
    fbp_trn_curr_key bigint NOT NULL,
    fbp_trn_company_key bigint NOT NULL,
    "timestamp" integer,
    batch_id character varying(300) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    component_name character varying(40) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    tran_ou integer,
    fb_voucher_no character varying(40) COLLATE public.nocase,
    fb_voucher_date timestamp without time zone,
    recon_flag character varying(30) COLLATE public.nocase,
    document_no character varying(40) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    tran_date timestamp without time zone,
    entry_date timestamp without time zone,
    auth_date timestamp without time zone,
    posting_date timestamp without time zone,
    ou_id integer,
    account_code character varying(80) COLLATE public.nocase,
    drcr_flag character varying(20) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    tran_amount numeric(20,2),
    base_amount numeric(20,2),
    par_base_amount numeric(20,2),
    exchange_rate numeric(20,2),
    par_exchange_rate numeric(20,2),
    narration character varying(510) COLLATE public.nocase,
    bank_code character varying(80) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    item_code character varying(80) COLLATE public.nocase,
    item_variant character varying(140) COLLATE public.nocase,
    quantity numeric(20,2),
    tax_post_flag character varying(10) COLLATE public.nocase,
    mac_post_flag character varying(10) COLLATE public.nocase,
    reftran_fbid character varying(40) COLLATE public.nocase,
    reftran_no character varying(40) COLLATE public.nocase,
    reftran_ou integer,
    ref_tran_type character varying(80) COLLATE public.nocase,
    supcust_code character varying(40) COLLATE public.nocase,
    uom character varying(30) COLLATE public.nocase,
    mac_inc_flag character varying(30) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    fin_year_code character varying(30) COLLATE public.nocase,
    fin_period_code character varying(30) COLLATE public.nocase,
    updated_flag character varying(30) COLLATE public.nocase,
    recon_date timestamp without time zone,
    hdrremarks character varying(512) COLLATE public.nocase,
    mlremarks character varying(512) COLLATE public.nocase,
    isrepupdated character varying(30) COLLATE public.nocase,
    afe_number character varying(40) COLLATE public.nocase,
    line_no integer,
    item_tcd_type character varying(30) COLLATE public.nocase,
    source_comp character varying(40) COLLATE public.nocase,
    defermentamount numeric(20,2),
    ari_upd_flag character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);