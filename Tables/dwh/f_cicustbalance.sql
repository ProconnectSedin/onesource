-- Table: dwh.f_cicustbalance

-- DROP TABLE IF EXISTS dwh.f_cicustbalance;

CREATE TABLE IF NOT EXISTS dwh.f_cicustbalance
(
    ci_cust_balance_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    cicustbalance_company_key bigint NOT NULL,
    cicustbalance_customer_key bigint NOT NULL,
    cicustbalance_opcoa_key bigint NOT NULL,
    cicustbalance_curr_key bigint NOT NULL,
    ou_id integer,
    company_code character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    fin_year character varying(30) COLLATE public.nocase,
    fin_period character varying(30) COLLATE public.nocase,
    cust_code character varying(36) COLLATE public.nocase,
    account_code character varying(64) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    balance_type character varying(10) COLLATE public.nocase,
    balance_currency character varying(10) COLLATE public.nocase,
    "timestamp" integer,
    ob_credit numeric(25,2),
    ob_debit numeric(25,2),
    period_credit numeric(25,2),
    period_debit numeric(25,2),
    cb_credit numeric(25,2),
    cb_debit numeric(25,2),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    account_type character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_cicustbalance_pkey PRIMARY KEY (ci_cust_balance_key),
    CONSTRAINT f_cicustbalance_ukey UNIQUE (ou_id, company_code, fb_id, fin_year, fin_period, cust_code, account_code, currency_code, balance_type, balance_currency),
    CONSTRAINT f_cicustbalance_cicustbalance_company_key_fkey FOREIGN KEY (cicustbalance_company_key)
        REFERENCES dwh.d_company (company_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_cicustbalance_cicustbalance_curr_key_fkey FOREIGN KEY (cicustbalance_curr_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_cicustbalance_cicustbalance_customer_key_fkey FOREIGN KEY (cicustbalance_customer_key)
        REFERENCES dwh.d_customer (customer_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_cicustbalance_cicustbalance_opcoa_key_fkey FOREIGN KEY (cicustbalance_opcoa_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cicustbalance
    OWNER to proconnect;