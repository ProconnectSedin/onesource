-- Table: stg.stg_stn_payment_hdr

-- DROP TABLE IF EXISTS stg.stg_stn_payment_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_stn_payment_hdr
(
    ou_id integer NOT NULL,
    trns_credit_note character varying(72) COLLATE public.nocase NOT NULL,
    pay_term character varying(60) COLLATE public.nocase NOT NULL,
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    status character varying(8) COLLATE public.nocase,
    disc_computation character varying(120) COLLATE public.nocase,
    elec_payment character varying(4) COLLATE public.nocase,
    payment_method character varying(100) COLLATE public.nocase,
    payment_route character varying(40) COLLATE public.nocase,
    pay_mode character varying(100) COLLATE public.nocase,
    esr_part_id character varying(120) COLLATE public.nocase,
    partid_digits integer,
    esr_ref_no character varying(120) COLLATE public.nocase,
    lsv_bank_code character varying(128) COLLATE public.nocase,
    lsv_contract_id character varying(24) COLLATE public.nocase,
    lsv_contract_ref character varying(72) COLLATE public.nocase,
    comp_acct_in character varying(60) COLLATE public.nocase,
    comp_bnkptt_acct character varying(128) COLLATE public.nocase,
    comp_bnkptt_ref character varying(72) COLLATE public.nocase,
    supp_acct_in character varying(60) COLLATE public.nocase,
    supp_bnkptt_acct character varying(128) COLLATE public.nocase,
    supp_bnkptt_ref character varying(72) COLLATE public.nocase,
    ps_pi_flag character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT stn_payment_hdr_pkey PRIMARY KEY (ou_id, trns_credit_note, pay_term, tran_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_stn_payment_hdr
    OWNER to proconnect;
-- Index: stg_stn_payment_hdr_key_idx

-- DROP INDEX IF EXISTS stg.stg_stn_payment_hdr_key_idx;

CREATE INDEX IF NOT EXISTS stg_stn_payment_hdr_key_idx
    ON stg.stg_stn_payment_hdr USING btree
    (ou_id ASC NULLS LAST, trns_credit_note COLLATE public.nocase ASC NULLS LAST, pay_term COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;