CREATE TABLE raw.raw_jv_voucher_trn_dtl (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    voucher_no character varying(72) NOT NULL COLLATE public.nocase,
    voucher_serial_no integer NOT NULL,
    "timestamp" integer,
    account_code character varying(128) COLLATE public.nocase,
    drcr_flag character varying(24) COLLATE public.nocase,
    tran_currency character varying(20) COLLATE public.nocase,
    tran_amount numeric,
    exchange_rate numeric,
    par_exchange_rate numeric,
    base_amount numeric,
    par_base_amount numeric,
    remarks character varying(1020) COLLATE public.nocase,
    costcenter_code character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanal_code character varying(20) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    destfbid character varying(80) COLLATE public.nocase,
    destaccountcode character varying(128) COLLATE public.nocase,
    intercompjv character varying(72) COLLATE public.nocase,
    dest_cost_center character varying(40) COLLATE public.nocase,
    dest_analysis_code character varying(20) COLLATE public.nocase,
    dest_subanalysis_code character varying(20) COLLATE public.nocase,
    account_currency character varying(20) COLLATE public.nocase,
    base_erate_inacccur numeric,
    pbase_erate_inacccur numeric,
    des_ouid integer,
    cfs_refdoc_ou integer,
    cfs_refdoc_no character varying(72) COLLATE public.nocase,
    cfs_refdoc_type character varying(160) COLLATE public.nocase,
    dest_company character varying(40) COLLATE public.nocase,
    revintercompjv character varying(72) COLLATE public.nocase,
    proposal_number character varying(1020) COLLATE public.nocase,
    pending_cap_amount numeric,
    capitalized_amount numeric,
    usage_id character varying(80) COLLATE public.nocase,
    ifb_recon_jvno character varying(72) COLLATE public.nocase,
    cap_flag character varying(48) COLLATE public.nocase,
    writeoff_amt numeric,
    writeoff_remarks character varying(400) COLLATE public.nocase,
    writeoff_jvno character varying(72) COLLATE public.nocase,
    writeoff_doc_ou integer,
    writeoff_doc_no character varying(72) COLLATE public.nocase,
    writeoff_doc_type character varying(160) COLLATE public.nocase,
    guid1 character varying(512) COLLATE public.nocase,
    writeoff_doc_lineno integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_jv_voucher_trn_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_jv_voucher_trn_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_jv_voucher_trn_dtl
    ADD CONSTRAINT raw_jv_voucher_trn_dtl_pkey PRIMARY KEY (raw_id);