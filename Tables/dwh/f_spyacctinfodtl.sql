-- Table: dwh.f_spyacctinfodtl

-- DROP TABLE IF EXISTS dwh.f_spyacctinfodtl;

CREATE TABLE IF NOT EXISTS dwh.f_spyacctinfodtl
(
    spyacctinfodtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    account_code_key bigint NOT NULL,
    currency_key bigint NOT NULL,
    ou_id integer,
    posting_line_no integer,
    tran_no character varying(36) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    account_code character varying(64) COLLATE public.nocase,
    drcr_flag character varying(12) COLLATE public.nocase,
    "timestamp" integer,
    account_type character varying(30) COLLATE public.nocase,
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
    batch_id character varying(256) COLLATE public.nocase,
    paybatch_no character varying(36) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    component_name character varying(32) COLLATE public.nocase,
    cr_doc_no character varying(36) COLLATE public.nocase,
    cr_doc_ou integer,
    cr_doc_type character varying(50) COLLATE public.nocase,
    cr_doc_term character varying(40) COLLATE public.nocase,
    posting_flag character varying(24) COLLATE public.nocase,
    fin_post_flag character varying(24) COLLATE public.nocase,
    hdrremarks character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_spyacctinfodtl_pkey PRIMARY KEY (spyacctinfodtl_key),
    CONSTRAINT f_spyacctinfodtl_ukey UNIQUE (ou_id, posting_line_no, tran_no, tran_type, account_code, drcr_flag),
    CONSTRAINT f_spyacctinfodtl_account_code_key_fkey FOREIGN KEY (account_code_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_spyacctinfodtl_currency_key_fkey FOREIGN KEY (currency_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_spyacctinfodtl
    OWNER to proconnect;
-- Index: f_spyacctinfodtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_spyacctinfodtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_spyacctinfodtl_key_idx1
    ON dwh.f_spyacctinfodtl USING btree
    (ou_id ASC NULLS LAST, posting_line_no ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;