CREATE TABLE stg.stg_sur_receipt_dtl (
    ou_id integer NOT NULL,
    receipt_type character varying(16) NOT NULL COLLATE public.nocase,
    receipt_no character varying(72) NOT NULL COLLATE public.nocase,
    refdoc_lineno integer NOT NULL,
    tran_type character varying(160) NOT NULL COLLATE public.nocase,
    stimestamp integer NOT NULL,
    usage character varying(80) COLLATE public.nocase,
    account_code character varying(128) COLLATE public.nocase,
    currency_code character varying(20) COLLATE public.nocase,
    account_amount numeric,
    drcr_flag character varying(16) COLLATE public.nocase,
    base_amount numeric,
    remarks character varying(1020) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    acct_type character varying(60) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    item_code character varying(128) COLLATE public.nocase,
    item_desc character varying(160) COLLATE public.nocase,
    dest_comp character varying(40) COLLATE public.nocase,
    cfs_refdoc_ou integer,
    cfs_refdoc_no character varying(72) COLLATE public.nocase,
    cfs_refdoc_type character varying(160) COLLATE public.nocase,
    desti_ou character varying(64) COLLATE public.nocase,
    desti_sac character varying(20) COLLATE public.nocase,
    interfbjvno character varying(72) COLLATE public.nocase,
    desti_ac character varying(20) COLLATE public.nocase,
    desti_acccode character varying(128) COLLATE public.nocase,
    desti_accdescrip character varying(240) COLLATE public.nocase,
    desti_cc character varying(128) COLLATE public.nocase,
    desti_fb character varying(80) COLLATE public.nocase,
    account_code_int character varying(128) COLLATE public.nocase,
    ifb_recon_jvno character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_sur_receipt_dtl
    ADD CONSTRAINT sur_receipt_dtl_pkey PRIMARY KEY (ou_id, receipt_type, receipt_no, refdoc_lineno, tran_type);

CREATE INDEX stg_sur_receipt_dtl_idx ON stg.stg_sur_receipt_dtl USING btree (ou_id, receipt_type, receipt_no, refdoc_lineno, tran_type);