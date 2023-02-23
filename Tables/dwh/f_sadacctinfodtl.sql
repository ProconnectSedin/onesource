-- Table: dwh.f_sadacctinfodtl

-- DROP TABLE IF EXISTS dwh.f_sadacctinfodtl;

CREATE TABLE IF NOT EXISTS dwh.f_sadacctinfodtl
(
    sadacctinfodtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    sadacctinfodtl_acckey bigint,
    sadacctinfodtl_currkey bigint,
    sadacctinfodtl_datekey bigint,
    sadacctinfodtl_cmpkey bigint,
    ou_id integer,
    tran_no character varying(40) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    drcr_flag character varying(20) COLLATE public.nocase,
    acct_line_no integer,
    fin_post_date timestamp without time zone,
    currency_code character varying(10) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    tran_amount numeric(13,2),
    fb_id character varying(40) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    basecur_erate numeric(13,2),
    base_amount numeric(13,2),
    pbcur_erate numeric(13,2),
    par_base_amt numeric(13,2),
    fin_post_status character varying(50) COLLATE public.nocase,
    transaction_date timestamp without time zone,
    account_type character varying(30) COLLATE public.nocase,
    guid character varying(260) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    ref_doc_no character varying(40) COLLATE public.nocase,
    component_name character varying(40) COLLATE public.nocase,
    ref_doc_ou integer,
    ref_doc_type character varying(80) COLLATE public.nocase,
    ref_doc_term character varying(40) COLLATE public.nocase,
    comments character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_sadacctinfodtl_pkey PRIMARY KEY (sadacctinfodtl_key),
    CONSTRAINT f_sadacctinfodtl_ukey UNIQUE (ou_id, tran_no, tran_type, account_code, drcr_flag, acct_line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_sadacctinfodtl
    OWNER to proconnect;
-- Index: f_sadacctinfodtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_sadacctinfodtl_key_idx;

CREATE INDEX IF NOT EXISTS f_sadacctinfodtl_key_idx
    ON dwh.f_sadacctinfodtl USING btree
    (ou_id ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST, acct_line_no ASC NULLS LAST)
    TABLESPACE pg_default;