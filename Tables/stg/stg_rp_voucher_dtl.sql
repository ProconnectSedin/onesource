-- Table: stg.stg_rp_voucher_dtl

-- DROP TABLE IF EXISTS stg.stg_rp_voucher_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_rp_voucher_dtl
(
    ou_id integer NOT NULL,
    serial_no integer NOT NULL,
    doc_type character varying(48) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    voucher_no character varying(72) COLLATE public.nocase NOT NULL,
    payment_category character varying(160) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    checkseries_no character varying(128) COLLATE public.nocase,
    check_no character varying(120) COLLATE public.nocase,
    comp_reference character varying(160) COLLATE public.nocase,
    currency character varying(20) COLLATE public.nocase,
    payee_name character varying(480) COLLATE public.nocase,
    voucher_date timestamp without time zone,
    voucher_amount numeric,
    fb_id character varying(80) COLLATE public.nocase,
    bank_code character varying(128) COLLATE public.nocase,
    flag character varying(16) COLLATE public.nocase,
    pay_date timestamp without time zone,
    priority character varying(16) COLLATE public.nocase,
    address character varying(160) COLLATE public.nocase,
    pay_mode character varying(100) COLLATE public.nocase,
    voucher_status character varying(16) COLLATE public.nocase,
    void_tran_no character varying(72) COLLATE public.nocase,
    nolinesinstub integer,
    stubpropt character varying(16) COLLATE public.nocase,
    void_date timestamp without time zone,
    eft_no character varying(72) COLLATE public.nocase,
    eft_type character varying(100) COLLATE public.nocase,
    doc_status character varying(48) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    filepath character varying(400) COLLATE public.nocase,
    paybatch_no character varying(72) COLLATE public.nocase,
    pay_charges numeric,
    consistency_stamp character varying(48) COLLATE public.nocase,
    company_code character varying(40) COLLATE public.nocase,
    bank_acc_no character varying(80) COLLATE public.nocase,
    pdc_flag character varying(48) COLLATE public.nocase,
    pdc_void_flag character varying(48) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    paycharges_bnkcur numeric,
    ifsccode character varying(80) COLLATE public.nocase,
    party_accno character varying(80) COLLATE public.nocase,
    party_ifsccode character varying(80) COLLATE public.nocase,
    party_asspaymd character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT rp_voucher_dtl_pkey PRIMARY KEY (ou_id, serial_no, doc_type, tran_ou, voucher_no, payment_category)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_rp_voucher_dtl
    OWNER to proconnect;

CREATE INDEX IF NOT EXISTS stg_rp_voucher_dtl_idx
    ON stg.stg_rp_voucher_dtl USING btree
    (ou_id, serial_no, doc_type, tran_ou, voucher_no, payment_category);
CREATE INDEX IF NOT EXISTS stg_rp_voucher_dtl_idx1
    ON stg.stg_rp_voucher_dtl USING btree
	(company_code, fb_id, bank_code, timestamp);
CREATE INDEX IF NOT EXISTS stg_rp_voucher_dtl_idx2
    ON stg.stg_rp_voucher_dtl USING btree
	(currency);
CREATE INDEX IF NOT EXISTS stg_rp_voucher_dtl_idx3
    ON stg.stg_rp_voucher_dtl USING btree
	(bank_acc_no, company_code);
CREATE INDEX IF NOT EXISTS stg_rp_voucher_dtl_idx4
    ON stg.stg_rp_voucher_dtl USING btree
	(company_code);
