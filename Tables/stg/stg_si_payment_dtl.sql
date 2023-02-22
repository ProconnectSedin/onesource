-- Table: stg.stg_si_payment_dtl

-- DROP TABLE IF EXISTS stg.stg_si_payment_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_si_payment_dtl
(
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    term_no character varying(80) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    due_percent numeric,
    disc_percent numeric,
    penalty_percent numeric,
    due_date timestamp without time zone,
    due_amount_type character varying(60) COLLATE public.nocase,
    due_precent numeric,
    due_amount numeric,
    disc_comp_amount numeric,
    disc_amount_type character varying(60) COLLATE public.nocase,
    disc_date timestamp without time zone,
    disc_precent numeric,
    disc_amount numeric,
    penalty_precent numeric,
    esr_ref_no character varying(72) COLLATE public.nocase,
    esr_coding_line character varying(72) COLLATE public.nocase,
    base_due_amount numeric,
    base_disc_amount numeric,
    lo_id character varying(80) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    "timestamp" integer,
    rev_due_date timestamp without time zone,
    rev_dis_date timestamp without time zone,
    rev_flag character varying(32) COLLATE public.nocase NOT NULL DEFAULT 'N'::character varying,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT si_payment_dtl_pkey UNIQUE (tran_type, tran_no, term_no, tran_ou)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_si_payment_dtl
    OWNER to proconnect;
-- Index: stg_si_payment_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_si_payment_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_si_payment_dtl_key_idx2
    ON stg.stg_si_payment_dtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST)
    TABLESPACE pg_default;