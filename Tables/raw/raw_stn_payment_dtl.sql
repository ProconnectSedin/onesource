-- Table: raw.raw_stn_payment_dtl

-- DROP TABLE IF EXISTS "raw".raw_stn_payment_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_stn_payment_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT stn_payment_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_stn_payment_dtl
    OWNER to proconnect;