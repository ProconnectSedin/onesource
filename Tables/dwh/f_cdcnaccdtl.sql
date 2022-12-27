CREATE TABLE dwh.f_cdcnaccdtl (
    cd_cn_accdtl_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    line_no integer,
    "timestamp" integer,
    account_code character varying(80) COLLATE public.nocase,
    drcr_id character varying(10) COLLATE public.nocase,
    ref_doc_type character varying(20) COLLATE public.nocase,
    ref_doc_no character varying(40) COLLATE public.nocase,
    ref_doc_date timestamp without time zone,
    ref_doc_amount numeric(20,2),
    ordering_ou integer,
    tran_amount numeric(20,2),
    remarks character varying(510) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    base_amount numeric(20,2),
    par_base_amount numeric(20,2),
    createddate timestamp without time zone,
    modifieddate timestamp without time zone,
    usageid character varying(40) COLLATE public.nocase,
    mail_sent character varying(50) COLLATE public.nocase,
    desti_accdescrip character varying(120) COLLATE public.nocase,
    own_tax_region character varying(20) COLLATE public.nocase,
    decl_tax_region character varying(20) COLLATE public.nocase,
    party_tax_region character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_cdcnaccdtl ALTER COLUMN cd_cn_accdtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_cdcnaccdtl_cd_cn_accdtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_cdcnaccdtl
    ADD CONSTRAINT f_cdcnaccdtl_pkey PRIMARY KEY (cd_cn_accdtl_key);

ALTER TABLE ONLY dwh.f_cdcnaccdtl
    ADD CONSTRAINT f_cdcnaccdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no);