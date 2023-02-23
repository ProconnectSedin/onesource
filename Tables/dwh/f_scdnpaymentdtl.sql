-- Table: dwh.f_scdnpaymentdtl

-- DROP TABLE IF EXISTS dwh.f_scdnpaymentdtl;

CREATE TABLE IF NOT EXISTS dwh.f_scdnpaymentdtl
(
    scdn_payment_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(36) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    due_date timestamp without time zone,
    due_amount_type character varying(2) COLLATE public.nocase,
    due_percent numeric(25,2),
    due_amount numeric(25,2),
    disc_comp_amount numeric(25,2),
    disc_amount_type character varying(2) COLLATE public.nocase,
    disc_date timestamp without time zone,
    disc_percent numeric(25,2),
    disc_amount numeric(25,2),
    penalty_percent numeric(25,2),
    base_due_amount numeric(25,2),
    base_disc_amount numeric(25,2),
    guid character varying(256) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_scdnpaymentdtl_pkey PRIMARY KEY (scdn_payment_dtl_key),
    CONSTRAINT f_scdnpaymentdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, term_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_scdnpaymentdtl
    OWNER to proconnect;