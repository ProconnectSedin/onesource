CREATE TABLE raw.raw_si_doc_hdr (
    raw_id bigint NOT NULL,
    tran_ou integer NOT NULL,
    tran_type character varying(40) NOT NULL COLLATE public.nocase,
    tran_no character varying(72) NOT NULL COLLATE public.nocase,
    "timestamp" integer NOT NULL,
    transfer_status character varying(100) COLLATE public.nocase,
    bankcashcode character varying(128) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    vat_incorporate_flag character varying(48) COLLATE public.nocase,
    tran_date timestamp without time zone,
    lo_id character varying(80) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    tran_currency character varying(20) COLLATE public.nocase,
    supplier_code character varying(64) COLLATE public.nocase,
    pay_term character varying(60) COLLATE public.nocase,
    payterm_version integer,
    tran_amount numeric,
    exchange_rate numeric,
    base_amount numeric,
    par_exchange_rate numeric,
    par_base_amount numeric,
    doc_status character varying(100) COLLATE public.nocase,
    reversed_docno character varying(72) COLLATE public.nocase,
    reversal_date timestamp without time zone,
    checkseries_no character varying(128) COLLATE public.nocase,
    check_no character varying(120) COLLATE public.nocase,
    bank_code character varying(128) COLLATE public.nocase,
    paid_status character varying(100) COLLATE public.nocase,
    vat_applicable character varying(4) COLLATE public.nocase,
    average_vat_rate numeric,
    discount_proportional character varying(4) COLLATE public.nocase,
    discount_amount numeric,
    discount_availed numeric,
    penalty_amount numeric,
    paid_amount numeric,
    requested_amount numeric,
    adjusted_amount numeric,
    supp_ou integer,
    reversed_docou integer,
    supp_name character varying(640) COLLATE public.nocase,
    supp_inv_no character varying(400) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    intbanktran_status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    cap_amount numeric,
    supp_invoice_date timestamp without time zone,
    component_id character varying(64) COLLATE public.nocase,
    ibe_flag character varying(48) COLLATE public.nocase,
    pay_to_supp character varying(64) COLLATE public.nocase,
    pay_mode character varying(100) COLLATE public.nocase,
    pay_priority character varying(160) COLLATE public.nocase,
    apply_sr character varying(16) COLLATE public.nocase,
    pay_method character varying(100) COLLATE public.nocase,
    lcnumber character varying(120) COLLATE public.nocase,
    refid character varying(480) COLLATE public.nocase,
    pdcflag character varying(48) COLLATE public.nocase,
    tr_amount numeric,
    tr_redeemed_amt numeric,
    tr_duedate timestamp without time zone,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    recon_flag character varying(48) COLLATE public.nocase,
    report_flag character varying(20) DEFAULT 'N'::character varying COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);