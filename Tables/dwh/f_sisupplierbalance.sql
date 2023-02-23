-- Table: dwh.f_sisupplierbalance

-- DROP TABLE IF EXISTS dwh.f_sisupplierbalance;

CREATE TABLE IF NOT EXISTS dwh.f_sisupplierbalance
(
    sisupplierbalance_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    account_code_key bigint NOT NULL,
    comp_code_key bigint NOT NULL,
    currency_key bigint NOT NULL,
    supp_key bigint NOT NULL,
    ou_id integer,
    company_code character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    fin_year character varying(30) COLLATE public.nocase,
    fin_period character varying(30) COLLATE public.nocase,
    supplier_code character varying(32) COLLATE public.nocase,
    account_code character varying(64) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    balance_type character varying(10) COLLATE public.nocase,
    balance_currency character varying(10) COLLATE public.nocase,
    account_type character varying(20) COLLATE public.nocase,
    ob_credit numeric(13,2),
    ob_debit numeric(13,2),
    period_credit numeric(13,2),
    period_debit numeric(13,2),
    cb_credit numeric(13,2),
    cb_debit numeric(13,2),
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    last_modified_by character varying(60) COLLATE public.nocase,
    last_modified_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_sisupplierbalance_pkey PRIMARY KEY (sisupplierbalance_key),
    CONSTRAINT f_sisupplierbalance_ukey UNIQUE (ou_id, company_code, fb_id, fin_year, fin_period, supplier_code, account_code, currency_code, balance_type, balance_currency),
    CONSTRAINT f_sisupplierbalance_account_code_key_fkey FOREIGN KEY (account_code_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_sisupplierbalance_comp_code_key_fkey FOREIGN KEY (comp_code_key)
        REFERENCES dwh.d_company (company_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_sisupplierbalance_currency_key_fkey FOREIGN KEY (currency_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_sisupplierbalance_supp_key_fkey FOREIGN KEY (supp_key)
        REFERENCES dwh.d_vendor (vendor_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_sisupplierbalance
    OWNER to proconnect;
-- Index: f_sisupplierbalance_key_idx1

-- DROP INDEX IF EXISTS dwh.f_sisupplierbalance_key_idx1;

CREATE INDEX IF NOT EXISTS f_sisupplierbalance_key_idx1
    ON dwh.f_sisupplierbalance USING btree
    (ou_id ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, fin_year COLLATE public.nocase ASC NULLS LAST, fin_period COLLATE public.nocase ASC NULLS LAST, supplier_code COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, currency_code COLLATE public.nocase ASC NULLS LAST, balance_type COLLATE public.nocase ASC NULLS LAST, balance_currency COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;