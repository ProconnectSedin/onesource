-- Table: dwh.f_stnpaymentdtl

-- DROP TABLE IF EXISTS dwh.f_stnpaymentdtl;

CREATE TABLE IF NOT EXISTS dwh.f_stnpaymentdtl
(
    stnpaymentdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    stnpaymenthdr_key bigint,
    stnpaymentdtl_datekey bigint,
    tran_type character varying(20) COLLATE public.nocase,
    ou_id integer,
    trns_credit_note character varying(40) COLLATE public.nocase,
    pay_term character varying(30) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    due_date timestamp without time zone,
    due_amt_type character varying(30) COLLATE public.nocase,
    due_percent numeric(13,2),
    due_amount numeric(13,2),
    disc_amount_type character varying(60) COLLATE public.nocase,
    dis_comp_amt numeric(13,2),
    discount_date timestamp without time zone,
    disc_percent numeric(13,2),
    discount numeric(13,2),
    penalty_percent numeric(13,2),
    esr_ref_no character varying(40) COLLATE public.nocase,
    esr_amount numeric(13,2),
    esr_code_line character varying(260) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_stnpaymentdtl_pkey PRIMARY KEY (stnpaymentdtl_key),
    CONSTRAINT f_stnpaymentdtl_ukey UNIQUE (tran_type, ou_id, trns_credit_note, pay_term, term_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_stnpaymentdtl
    OWNER to proconnect;
-- Index: f_stnpaymentdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_stnpaymentdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_stnpaymentdtl_key_idx
    ON dwh.f_stnpaymentdtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST, trns_credit_note COLLATE public.nocase ASC NULLS LAST, pay_term COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;