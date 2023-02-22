-- Table: dwh.f_cpacctinfo

-- DROP TABLE IF EXISTS dwh.f_cpacctinfo;

CREATE TABLE IF NOT EXISTS dwh.f_cpacctinfo
(
    cpacctinfo_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    account_code_key bigint NOT NULL,
    comp_code_key bigint NOT NULL,
    cpacctinfo_currency_key bigint NOT NULL,
    cpacctinfo_date_key bigint NOT NULL,
    ou_id integer,
    tran_no character varying(36) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    acc_code character varying(64) COLLATE public.nocase,
    drcr_flag character varying(12) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    line_no integer,
    "timestamp" integer,
    tran_date timestamp without time zone,
    fin_post_date timestamp without time zone,
    currency character varying(10) COLLATE public.nocase,
    tran_amt numeric(13,2),
    business_unit character varying(40) COLLATE public.nocase,
    base_cur_exrate numeric(13,2),
    base_amt numeric(13,2),
    par_base_cur_exrate numeric(13,2),
    par_base_amt numeric(13,2),
    status character varying(50) COLLATE public.nocase,
    batch_id character varying(256) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    component_name character varying(320) COLLATE public.nocase,
    acct_type character varying(30) COLLATE public.nocase,
    bank_cash_code character varying(64) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    posting_flag character varying(24) COLLATE public.nocase,
    remarks character varying(512) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_cpacctinfo_pkey PRIMARY KEY (cpacctinfo_key),
    CONSTRAINT f_cpacctinfo_ukey UNIQUE (ou_id, tran_no, fb_id, acc_code, drcr_flag, tran_type, line_no),
    CONSTRAINT f_cpacctinfo_account_code_key_fkey FOREIGN KEY (account_code_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_cpacctinfo_comp_code_key_fkey FOREIGN KEY (comp_code_key)
        REFERENCES dwh.d_company (company_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_cpacctinfo_cpacctinfo_currency_key_fkey FOREIGN KEY (cpacctinfo_currency_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_cpacctinfo_cpacctinfo_date_key_fkey FOREIGN KEY (cpacctinfo_date_key)
        REFERENCES dwh.d_date (datekey) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cpacctinfo
    OWNER to proconnect;
-- Index: f_cpacctinfo_key_idx1

-- DROP INDEX IF EXISTS dwh.f_cpacctinfo_key_idx1;

CREATE INDEX IF NOT EXISTS f_cpacctinfo_key_idx1
    ON dwh.f_cpacctinfo USING btree
    (ou_id ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, acc_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;