-- Table: dwh.f_adeppaccountinginfodtl

-- DROP TABLE IF EXISTS dwh.f_adeppaccountinginfodtl;

CREATE TABLE IF NOT EXISTS dwh.f_adeppaccountinginfodtl
(
    adeppaccountinginfodtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    account_code_key bigint NOT NULL,
    comp_code_key bigint NOT NULL,
    currency_key bigint NOT NULL,
    ou_id integer,
    company_code character varying(20) COLLATE public.nocase,
    tran_number character varying(40) COLLATE public.nocase,
    asset_number character varying(40) COLLATE public.nocase,
    tag_number integer,
    tran_type character varying(80) COLLATE public.nocase,
    tran_date timestamp without time zone,
    posting_date timestamp without time zone,
    account_code character varying(80) COLLATE public.nocase,
    drcr_flag character varying(20) COLLATE public.nocase,
    currency character varying(10) COLLATE public.nocase,
    tran_amount numeric(13,2),
    fb_id character varying(40) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    bc_erate numeric(13,2),
    base_amount numeric(13,2),
    pbase_amount numeric(13,2),
    account_type character varying(80) COLLATE public.nocase,
    fin_period character varying(20) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    batch_id character varying(260) COLLATE public.nocase,
    depr_book character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_adeppaccountinginfodtl_pkey PRIMARY KEY (adeppaccountinginfodtl_key),
    CONSTRAINT f_adeppaccountinginfodtl_ukey UNIQUE (ou_id, company_code, tran_number, asset_number, tag_number, tran_date, account_code, drcr_flag, fb_id, bu_id, fin_period),
    CONSTRAINT f_adeppaccountinginfodtl_account_code_key_fkey FOREIGN KEY (account_code_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_adeppaccountinginfodtl_comp_code_key_fkey FOREIGN KEY (comp_code_key)
        REFERENCES dwh.d_company (company_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_adeppaccountinginfodtl_currency_key_fkey FOREIGN KEY (currency_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_adeppaccountinginfodtl
    OWNER to proconnect;
-- Index: f_adeppaccountinginfodtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_adeppaccountinginfodtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_adeppaccountinginfodtl_key_idx1
    ON dwh.f_adeppaccountinginfodtl USING btree
    (ou_id ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, tran_number COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, tran_date ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, bu_id COLLATE public.nocase ASC NULLS LAST, fin_period COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;