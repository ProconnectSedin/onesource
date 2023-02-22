-- Table: dwh.f_sracctinfodtl

-- DROP TABLE IF EXISTS dwh.f_sracctinfodtl;

CREATE TABLE IF NOT EXISTS dwh.f_sracctinfodtl
(
    sracctinfodtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    account_code_key bigint NOT NULL,
    currency_key bigint NOT NULL,
    ou_id integer,
    tran_no character varying(40) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    acct_lineno integer,
    fb_id character varying(40) COLLATE public.nocase,
    acc_code character varying(80) COLLATE public.nocase,
    drcr_flag character varying(20) COLLATE public.nocase,
    "timestamp" integer,
    acct_type character varying(20) COLLATE public.nocase,
    fin_post_date timestamp without time zone,
    currency character varying(10) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    tran_amt numeric(13,2),
    business_unit character varying(40) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    sub_analysis_code character varying(10) COLLATE public.nocase,
    base_cur_exrate numeric(13,2),
    base_amt numeric(13,2),
    par_base_cur_exrate numeric(13,2),
    par_base_amt numeric(13,2),
    status character varying(50) COLLATE public.nocase,
    batch_id character varying(260) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    hdrremarks character varying(510) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(140) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_sracctinfodtl_pkey PRIMARY KEY (sracctinfodtl_key),
    CONSTRAINT f_sracctinfodtl_ukey UNIQUE (ou_id, tran_no, tran_type, acct_lineno, fb_id, acc_code, drcr_flag),
    CONSTRAINT f_sracctinfodtl_account_code_key_fkey FOREIGN KEY (account_code_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_sracctinfodtl_currency_key_fkey FOREIGN KEY (currency_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_sracctinfodtl
    OWNER to proconnect;
-- Index: f_sracctinfodtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_sracctinfodtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_sracctinfodtl_key_idx1
    ON dwh.f_sracctinfodtl USING btree
    (ou_id ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, acct_lineno ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, acc_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;