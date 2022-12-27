CREATE TABLE raw.raw_spy_paybatch_dtl (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    paybatch_no character varying(72) NOT NULL COLLATE public.nocase,
    cr_doc_ou integer NOT NULL,
    cr_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    term_no character varying(80) NOT NULL COLLATE public.nocase,
    tran_type character varying(100) NOT NULL COLLATE public.nocase,
    ptimestamp integer NOT NULL,
    cr_doc_type character varying(160) COLLATE public.nocase,
    pay_currency character varying(20) COLLATE public.nocase,
    parbasecur_erate numeric,
    tran_amount numeric,
    discount numeric,
    penalty numeric,
    pay_mode character varying(100) COLLATE public.nocase,
    proposed_penalty numeric,
    proposed_discount numeric,
    basecur_erate numeric,
    crosscur_erate numeric,
    supp_ctrl_acct character varying(128) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    lsv_id character varying(72) COLLATE public.nocase,
    esr_line character varying(72) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    supplier_code character varying(320) COLLATE public.nocase,
    cr_doc_cur character varying(20) COLLATE public.nocase,
    cr_doc_amount numeric,
    cr_doc_fb_id character varying(80) COLLATE public.nocase,
    tran_net_amount numeric,
    pay_amount numeric,
    pay_to_supp character varying(64) COLLATE public.nocase,
    pay_cur_erate numeric,
    ctrl_acct_type character varying(60) COLLATE public.nocase,
    bankcurrency character varying(20) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    prop_wht_amt numeric,
    app_wht_amt numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_spy_paybatch_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_spy_paybatch_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_spy_paybatch_dtl
    ADD CONSTRAINT raw_spy_paybatch_dtl_pkey PRIMARY KEY (raw_id);