-- Table: dwh.f_cidocbalance

-- DROP TABLE IF EXISTS dwh.f_cidocbalance;

CREATE TABLE IF NOT EXISTS dwh.f_cidocbalance
(
    ci_doc_balance_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    cidocbalance_curr_key bigint NOT NULL,
    cidocbalance_customer_key bigint NOT NULL,
    cidocbalance_opcoa_key bigint NOT NULL,
    tran_ou integer,
    tran_type character varying(20) COLLATE public.nocase,
    tran_no character varying(36) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    batch_id character varying(256) COLLATE public.nocase,
    lo_id character varying(40) COLLATE public.nocase,
    tran_currency character varying(10) COLLATE public.nocase,
    basecur_erate numeric(25,2),
    base_amount numeric(25,2),
    tran_amount numeric(25,2),
    par_exchange_rate numeric(25,2),
    par_base_amount numeric(25,2),
    doc_status character varying(50) COLLATE public.nocase,
    adjustment_status character varying(50) COLLATE public.nocase,
    unadjusted_amt numeric(25,2),
    paid_amt numeric(25,2),
    disc_availed numeric(25,2),
    written_off_amt numeric(25,2),
    provision_amt_cm numeric(25,2),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    discount_amount numeric(25,2),
    adjusted_amount numeric(25,2),
    received_amount numeric(25,2),
    penalty_amount numeric(25,2),
    write_back_amount numeric(25,2),
    vat_amount numeric(25,2),
    outstanding_amount numeric(25,2),
    pay_term character varying(30) COLLATE public.nocase,
    recpt_consumed numeric(25,2),
    rv_amount numeric(25,2),
    cpi_cr_unadj_amount numeric(25,2),
    cust_code character varying(36) COLLATE public.nocase,
    tran_date timestamp without time zone,
    account_code character varying(64) COLLATE public.nocase,
    account_type character varying(30) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    posting_date timestamp without time zone,
    base_outstanding_amt numeric(25,2),
    pbase_outstanding_amt numeric(25,2),
    base_adjusted_amount numeric(25,2),
    pbase_adjusted_amount numeric(25,2),
    base_recpt_consumed numeric(25,2),
    pbase_recpt_consumed numeric(25,2),
    base_received_amount numeric(25,2),
    pbase_received_amount numeric(25,2),
    base_written_off_amt numeric(25,2),
    pbase_written_off_amt numeric(25,2),
    due_date timestamp without time zone,
    discount_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_cidocbalance_pkey PRIMARY KEY (ci_doc_balance_key),
    CONSTRAINT f_cidocbalance_ukey UNIQUE (tran_ou, tran_type, tran_no, term_no, account_type),
    CONSTRAINT f_cidocbalance_cidocbalance_curr_key_fkey FOREIGN KEY (cidocbalance_curr_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_cidocbalance_cidocbalance_customer_key_fkey FOREIGN KEY (cidocbalance_customer_key)
        REFERENCES dwh.d_customer (customer_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_cidocbalance_cidocbalance_opcoa_key_fkey FOREIGN KEY (cidocbalance_opcoa_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cidocbalance
    OWNER to proconnect;