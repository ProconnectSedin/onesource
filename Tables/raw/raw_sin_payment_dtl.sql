CREATE TABLE IF NOT EXISTS "raw".raw_sin_payment_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(36) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    posting_status character varying(6) COLLATE pg_catalog."default",
    posting_date timestamp without time zone,
    due_date timestamp without time zone,
    due_amount_type character varying(10) COLLATE public.nocase,
    due_percent numeric(20,2),
    due_amount numeric(20,2),
    disc_comp_amount numeric(20,2),
    disc_amount_type character varying(10) COLLATE public.nocase,
    disc_date timestamp without time zone,
    disc_percent numeric(20,2),
    disc_amount numeric(20,2),
    penalty_percent numeric(20,2),
    esr_ref_no character varying(60) COLLATE pg_catalog."default",
    esr_coding_line character varying(256) COLLATE pg_catalog."default",
    esr_amount numeric(20,2),
    base_due_amount numeric(20,2),
    base_disc_amount numeric(20,2),
    base_esr_amount numeric(20,2),
    guid character varying(256) COLLATE public.nocase,
    createdby character varying(120) COLLATE pg_catalog."default",
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE pg_catalog."default",
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone
)