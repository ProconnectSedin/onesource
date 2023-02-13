CREATE TABLE IF NOT EXISTS stg.stg_si_acct_info_dtl
(
    tran_ou integer NOT NULL,
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    line_no integer NOT NULL,
    capitalized_amount numeric,
    vat_line_no integer,
    component_id character varying(64) COLLATE public.nocase,
    exchange_rate numeric,
    company_code character varying(40) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    account_code character varying(128) COLLATE public.nocase,
    drcr_flag character varying(24) COLLATE public.nocase,
    txnou_id integer,
    bu_id character varying(80) COLLATE public.nocase,
    tran_date timestamp without time zone,
    tran_qty numeric,
    tran_amount_acc_cur numeric,
    ctrl_acct_type character varying(60) COLLATE public.nocase,
    auto_post_acct_type character varying(60) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    bank_code character varying(128) COLLATE public.nocase,
    item_code character varying(128) COLLATE public.nocase,
    item_variant character varying(32) COLLATE public.nocase,
    uom character varying(60) COLLATE public.nocase,
    supplier_code character varying(64) COLLATE public.nocase,
    acct_currency character varying(20) COLLATE public.nocase,
    basecur_erate numeric,
    base_amount numeric,
    par_exchange_rate numeric,
    par_base_amount numeric,
    narration character varying(1020) COLLATE public.nocase,
    auth_date timestamp without time zone,
    ref_doc_ou integer,
    ref_doc_fb_id character varying(80) COLLATE public.nocase,
    ref_doc_type character varying(40) COLLATE public.nocase,
    ref_doc_no character varying(72) COLLATE public.nocase,
    vat_decl_year character varying(60) COLLATE public.nocase,
    vat_decl_period character varying(60) COLLATE public.nocase,
    vat_usage_flag character varying(4) COLLATE public.nocase,
    vat_category character varying(160) COLLATE public.nocase,
    vat_class character varying(160) COLLATE public.nocase,
    vat_code character varying(160) COLLATE public.nocase,
    vat_rate numeric,
    posting_date timestamp without time zone,
    posting_status character varying(4) COLLATE public.nocase,
    base_currency character varying(20) COLLATE public.nocase,
    par_base_currency character varying(20) COLLATE public.nocase,
    vat_posting_flag character varying(4) COLLATE public.nocase,
    vat_posting_date timestamp without time zone,
    account_type character varying(60) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    ref_doclineno integer,
    "timestamp" integer,
    vatusage character varying(80) COLLATE public.nocase,
    ibe_flag character varying(48) COLLATE public.nocase,
    fin_year character varying(60) COLLATE public.nocase,
    fin_period character varying(60) COLLATE public.nocase,
    fbp_post_flag character varying(48) COLLATE public.nocase,
    hdrremarks character varying(1020) COLLATE public.nocase,
    mlremarks character varying(1020) COLLATE public.nocase,
    acct_pdc_flag character varying(48) COLLATE public.nocase,
    oldguid_regen character varying(512) COLLATE public.nocase,
    oldcomp_regen character varying(64) COLLATE public.nocase,
    pdc_void_flag character varying(48) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    afe_number character varying(72) COLLATE public.nocase,
    job_number character varying(72) COLLATE public.nocase,
    refcostcenter_hdr character varying(40) COLLATE public.nocase,
    instr_no character varying(120) COLLATE public.nocase,
    tranline_no integer,
    defermentamount numeric,
    rowtype character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)