-- Table: stg.stg_cdi_payment_dtl

-- DROP TABLE IF EXISTS stg.stg_cdi_payment_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_cdi_payment_dtl
(
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    term_no character varying(80) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    posting_status character varying(12) COLLATE public.nocase,
    posting_date timestamp without time zone,
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
    guid character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    eslip_amount numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pk__cdi_payment_dtl__7104dd1a PRIMARY KEY (tran_type, tran_ou, tran_no, term_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_cdi_payment_dtl
    OWNER to proconnect;