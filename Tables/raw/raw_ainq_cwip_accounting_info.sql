CREATE TABLE raw.raw_ainq_cwip_accounting_info (
    raw_id bigint NOT NULL,
    tran_ou integer,
    component_id character varying(640) NOT NULL COLLATE public.nocase,
    company_code character varying(40) COLLATE public.nocase,
    asset_class character varying(80) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    tran_number character varying(72) COLLATE public.nocase,
    asset_number character varying(72) COLLATE public.nocase,
    tran_type character varying(160) COLLATE public.nocase,
    proposal_no character varying(72) COLLATE public.nocase,
    account_code character varying(128) COLLATE public.nocase,
    account_type character varying(160) COLLATE public.nocase,
    drcr_flag character varying(24) COLLATE public.nocase,
    currency character varying(20) COLLATE public.nocase,
    tran_amount numeric,
    tran_date timestamp without time zone,
    posting_date timestamp without time zone,
    depr_book character varying(80) COLLATE public.nocase,
    bc_erate numeric,
    base_amount numeric,
    pbc_erate numeric,
    pbase_amount numeric,
    batch_id character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    rpt_flag character varying(32) DEFAULT 'Y'::character varying NOT NULL COLLATE public.nocase,
    rpt_amount numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_ainq_cwip_accounting_info ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_ainq_cwip_accounting_info_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_ainq_cwip_accounting_info
    ADD CONSTRAINT raw_ainq_cwip_accounting_info_pkey PRIMARY KEY (raw_id);