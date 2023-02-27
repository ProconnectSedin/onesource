-- Table: stg.stg_ci_doc_balance

-- DROP TABLE IF EXISTS stg.stg_ci_doc_balance;

CREATE TABLE IF NOT EXISTS stg.stg_ci_doc_balance
(
    tran_ou integer NOT NULL,
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    term_no character varying(80) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    batch_id character varying(512) COLLATE public.nocase,
    lo_id character varying(80) COLLATE public.nocase,
    tran_currency character varying(20) COLLATE public.nocase,
    basecur_erate numeric,
    base_amount numeric,
    tran_amount numeric,
    par_exchange_rate numeric,
    par_base_amount numeric,
    doc_status character varying(100) COLLATE public.nocase,
    adjustment_status character varying(100) COLLATE public.nocase,
    unadjusted_amt numeric,
    paid_amt numeric,
    disc_availed numeric,
    written_off_amt numeric,
    provision_amt_cm numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    due_no_cm integer,
    discount_amount numeric,
    adjusted_amount numeric,
    received_amount numeric,
    penalty_amount numeric,
    write_back_amount numeric,
    vat_amount numeric,
    outstanding_amount numeric,
    pay_term character varying(60) COLLATE public.nocase,
    recpt_consumed numeric,
    rv_amount numeric,
    cpi_cr_unadj_amount numeric,
    payterm_version integer,
    charges_amount numeric,
    cr_adj_amount numeric,
    cust_code character varying(72) COLLATE public.nocase,
    tran_date timestamp without time zone,
    account_code character varying(128) COLLATE public.nocase,
    account_type character varying(60) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase,
    posting_date timestamp without time zone,
    base_outstanding_amt numeric,
    pbase_outstanding_amt numeric,
    base_adjusted_amount numeric,
    pbase_adjusted_amount numeric,
    base_recpt_consumed numeric,
    pbase_recpt_consumed numeric,
    base_received_amount numeric,
    pbase_received_amount numeric,
    base_written_off_amt numeric,
    pbase_written_off_amt numeric,
    base_cr_adj_amount numeric,
    pbase_cr_adj_amount numeric,
    due_date timestamp without time zone,
    discount_date timestamp without time zone,
    bookingno character varying(280) COLLATE public.nocase,
    masterbillofladingno character varying(280) COLLATE public.nocase,
    billofladingno character varying(280) COLLATE public.nocase,
    pdc_status character varying(100) COLLATE public.nocase,
    instr_no character varying(120) COLLATE public.nocase,
    rev_due_date timestamp without time zone,
    rev_discount_date timestamp without time zone,
    pdc_flag character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ci_doc_balance_pkey PRIMARY KEY (tran_ou, tran_type, tran_no, term_no, account_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ci_doc_balance
    OWNER to proconnect;
-- Index: stg_ci_doc_balance_idx

-- DROP INDEX IF EXISTS stg.stg_ci_doc_balance_idx;

CREATE INDEX IF NOT EXISTS stg_ci_doc_balance_idx
    ON stg.stg_ci_doc_balance USING btree
    (tran_ou ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST, account_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;