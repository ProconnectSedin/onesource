CREATE TABLE raw.raw_snp_voucher_dtl (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    voucher_no character varying(72) NOT NULL COLLATE public.nocase,
    voucher_type character varying(16) NOT NULL COLLATE public.nocase,
    account_lineno integer NOT NULL,
    tran_type character varying(160) NOT NULL COLLATE public.nocase,
    vtimestamp integer NOT NULL,
    usage_id character varying(80) COLLATE public.nocase,
    account_code character varying(128) COLLATE public.nocase,
    currency character varying(20) COLLATE public.nocase,
    amount numeric,
    drcr_flag character varying(16) COLLATE public.nocase,
    base_amount numeric,
    proposal_no character varying(72) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    acct_type character varying(40) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    receive_bank_cash_code character varying(128) COLLATE public.nocase,
    sur_receipt_no character varying(72) COLLATE public.nocase,
    dest_comp character varying(40) COLLATE public.nocase,
    cfs_refdoc_ou integer,
    cfs_refdoc_no character varying(72) COLLATE public.nocase,
    cfs_refdoc_type character varying(160) COLLATE public.nocase,
    destination_accode character varying(128) COLLATE public.nocase,
    destination_ou integer,
    destination_fb character varying(80) COLLATE public.nocase,
    destination_costcenter character varying(128) COLLATE public.nocase,
    destination_analysiscode character varying(20) COLLATE public.nocase,
    destination_subanalysiscode character varying(20) COLLATE public.nocase,
    destination_interfbjvno character varying(72) COLLATE public.nocase,
    accountcode_interfb character varying(128) COLLATE public.nocase,
    costcenter_interfb character varying(128) COLLATE public.nocase,
    analysis_code_interfb character varying(20) COLLATE public.nocase,
    sub_analysis_code_interfb character varying(20) COLLATE public.nocase,
    destaccount_currency character varying(20) COLLATE public.nocase,
    reciving_comp character varying(40) COLLATE public.nocase,
    sur_ou integer,
    ifb_recon_jvno character varying(72) COLLATE public.nocase,
    own_tax_region character varying(40) COLLATE public.nocase,
    party_tax_region character varying(40) COLLATE public.nocase,
    decl_tax_region character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_snp_voucher_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_snp_voucher_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_snp_voucher_dtl
    ADD CONSTRAINT raw_snp_voucher_dtl_pkey PRIMARY KEY (raw_id);