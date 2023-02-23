-- Table: stg.stg_stn_payment_dtl

-- DROP TABLE IF EXISTS stg.stg_stn_payment_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_stn_payment_dtl
(
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    ou_id integer NOT NULL,
    trns_credit_note character varying(72) COLLATE public.nocase NOT NULL,
    pay_term character varying(60) COLLATE public.nocase NOT NULL,
    term_no character varying(80) COLLATE public.nocase NOT NULL,
    due_date timestamp without time zone,
    due_amt_type character varying(60) COLLATE public.nocase,
    due_percent numeric,
    due_amount numeric,
    disc_amount_type character varying(120) COLLATE public.nocase,
    dis_comp_amt numeric,
    discount_date timestamp without time zone,
    disc_percent numeric,
    discount numeric,
    penalty_percent numeric,
    esr_ref_no character varying(72) COLLATE public.nocase,
    esr_amount numeric,
    esr_code_line character varying(512) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT stn_payment_dtl_pkey PRIMARY KEY (tran_type, ou_id, trns_credit_note, pay_term, term_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_stn_payment_dtl
    OWNER to proconnect;
-- Index: stg_stn_payment_dtl_key_idx

-- DROP INDEX IF EXISTS stg.stg_stn_payment_dtl_key_idx;

CREATE INDEX IF NOT EXISTS stg_stn_payment_dtl_key_idx
    ON stg.stg_stn_payment_dtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST, trns_credit_note COLLATE public.nocase ASC NULLS LAST, pay_term COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;