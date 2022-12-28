CREATE TABLE raw.raw_cdcn_acc_dtl (
    raw_id bigint NOT NULL,
    tran_type character varying(40) NOT NULL COLLATE public.nocase,
    tran_ou integer NOT NULL,
    tran_no character varying(72) NOT NULL COLLATE public.nocase,
    line_no integer NOT NULL,
    "timestamp" integer,
    account_code character varying(128) COLLATE public.nocase,
    drcr_id character varying(4) COLLATE public.nocase,
    ref_doc_type character varying(40) COLLATE public.nocase,
    ref_doc_no character varying(72) COLLATE public.nocase,
    ref_doc_date timestamp without time zone,
    ref_doc_amount numeric,
    ordering_ou integer,
    tran_amount numeric,
    remarks character varying(1020) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    base_amount numeric,
    par_base_amount numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    bookingno character varying(280) COLLATE public.nocase,
    billofladingno character varying(280) COLLATE public.nocase,
    masterbillofladingno character varying(280) COLLATE public.nocase,
    cfs_refdoc_ou integer,
    cfs_refdoc_no character varying(72) COLLATE public.nocase,
    cfs_refdoc_type character varying(160) COLLATE public.nocase,
    dest_usageid character varying(80) COLLATE public.nocase,
    incomeexpense character varying(128) COLLATE public.nocase,
    dest_subanalysis_code character varying(40) COLLATE public.nocase,
    dest_analysis_code character varying(40) COLLATE public.nocase,
    dest_cost_center character varying(40) COLLATE public.nocase,
    dest_remarks character varying(1020) COLLATE public.nocase,
    dest_tran_amount numeric,
    dest_drcr_id character varying(4) COLLATE public.nocase,
    dest_account_code character varying(128) COLLATE public.nocase,
    usageid character varying(80) COLLATE public.nocase,
    ccdesc character varying(1020) COLLATE public.nocase,
    mail_sent character varying(100) DEFAULT 'N'::character varying COLLATE public.nocase,
    draf_bill_no character varying(72) COLLATE public.nocase,
    draf_bill_line_no integer,
    desti_ou character varying(64) COLLATE public.nocase,
    desti_sac character varying(20) COLLATE public.nocase,
    interfbjvno character varying(72) COLLATE public.nocase,
    desti_ac character varying(20) COLLATE public.nocase,
    desti_acccode character varying(128) COLLATE public.nocase,
    desti_accdescrip character varying(240) COLLATE public.nocase,
    desti_cc character varying(128) COLLATE public.nocase,
    desti_comp character varying(40) COLLATE public.nocase,
    desti_fb character varying(80) COLLATE public.nocase,
    account_code_int character varying(128) COLLATE public.nocase,
    ifb_recon_jvno character varying(72) COLLATE public.nocase,
    own_tax_region character varying(40) COLLATE public.nocase,
    decl_tax_region character varying(40) COLLATE public.nocase,
    party_tax_region character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_cdcn_acc_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_cdcn_acc_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_cdcn_acc_dtl
    ADD CONSTRAINT raw_cdcn_acc_dtl_pkey PRIMARY KEY (raw_id);