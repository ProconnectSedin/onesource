-- Table: dwh.f_stnpaymenthdr

-- DROP TABLE IF EXISTS dwh.f_stnpaymenthdr;

CREATE TABLE IF NOT EXISTS dwh.f_stnpaymenthdr
(
    stnpaymenthdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    trns_credit_note character varying(40) COLLATE public.nocase,
    pay_term character varying(30) COLLATE public.nocase,
    tran_type character varying(20) COLLATE public.nocase,
    status character varying(10) COLLATE public.nocase,
    disc_computation character varying(60) COLLATE public.nocase,
    elec_payment character varying(10) COLLATE public.nocase,
    payment_method character varying(50) COLLATE public.nocase,
    payment_route character varying(20) COLLATE public.nocase,
    pay_mode character varying(50) COLLATE public.nocase,
    esr_part_id character varying(60) COLLATE public.nocase,
    partid_digits integer,
    esr_ref_no character varying(60) COLLATE public.nocase,
    lsv_bank_code character varying(80) COLLATE public.nocase,
    lsv_contract_id character varying(20) COLLATE public.nocase,
    lsv_contract_ref character varying(40) COLLATE public.nocase,
    comp_acct_in character varying(30) COLLATE public.nocase,
    comp_bnkptt_acct character varying(80) COLLATE public.nocase,
    comp_bnkptt_ref character varying(40) COLLATE public.nocase,
    supp_acct_in character varying(30) COLLATE public.nocase,
    supp_bnkptt_acct character varying(80) COLLATE public.nocase,
    supp_bnkptt_ref character varying(40) COLLATE public.nocase,
    ps_pi_flag character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_stnpaymenthdr_pkey PRIMARY KEY (stnpaymenthdr_key),
    CONSTRAINT f_stnpaymenthdr_ukey UNIQUE (ou_id, trns_credit_note, pay_term, tran_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_stnpaymenthdr
    OWNER to proconnect;
-- Index: f_stnpaymenthdr_key_idx

-- DROP INDEX IF EXISTS dwh.f_stnpaymenthdr_key_idx;

CREATE INDEX IF NOT EXISTS f_stnpaymenthdr_key_idx
    ON dwh.f_stnpaymenthdr USING btree
    (ou_id ASC NULLS LAST, trns_credit_note COLLATE public.nocase ASC NULLS LAST, pay_term COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;