-- Table: stg.stg_ci_doc_payterm_dtl

-- DROP TABLE IF EXISTS stg.stg_ci_doc_payterm_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_ci_doc_payterm_dtl
(
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    pay_term character varying(60) COLLATE public.nocase NOT NULL,
    term_no character varying(80) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    lo_id character varying(80) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    component_id character varying(64) COLLATE public.nocase,
    company_code character varying(40) COLLATE public.nocase,
    due_date timestamp without time zone,
    due_amount_type character varying(4) COLLATE public.nocase,
    due_percent numeric,
    due_amount numeric,
    disc_comp_amount numeric,
    disc_amount_type character varying(4) COLLATE public.nocase,
    disc_date timestamp without time zone,
    disc_percent numeric,
    disc_amount numeric,
    penalty_percent numeric,
    esr_ref_no character varying(120) COLLATE public.nocase,
    esr_coding_line character varying(512) COLLATE public.nocase,
    base_due_amount numeric,
    base_disc_amount numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    payterm_version integer,
    rev_due_date timestamp without time zone,
    rev_dis_date timestamp without time zone,
    rev_flag character varying(32) COLLATE public.nocase NOT NULL DEFAULT 'N'::character varying,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ci_doc_payterm_dtl_pkey PRIMARY KEY (tran_type, tran_ou, tran_no, pay_term, term_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ci_doc_payterm_dtl
    OWNER to proconnect;
-- Index: stg_ci_doc_payterm_dtl_idx

-- DROP INDEX IF EXISTS stg.stg_ci_doc_payterm_dtl_idx;

CREATE INDEX IF NOT EXISTS stg_ci_doc_payterm_dtl_idx
    ON stg.stg_ci_doc_payterm_dtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, pay_term COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;