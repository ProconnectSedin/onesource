-- Table: stg.stg_rp_voucher_hdr

-- DROP TABLE IF EXISTS stg.stg_rp_voucher_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_rp_voucher_hdr
(
    ou_id integer NOT NULL,
    serial_no integer NOT NULL,
    doc_type character varying(48) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    company_code character varying(40) COLLATE public.nocase,
    bank_acc_no character varying(80) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT rp_voucher_hdr_pkey PRIMARY KEY (ou_id, serial_no, doc_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_rp_voucher_hdr
    OWNER to proconnect;

CREATE INDEX IF NOT EXISTS stg_rp_voucher_hdr_idx
    ON stg.stg_rp_voucher_hdr USING btree
	(bank_acc_no, company_code);

CREATE INDEX IF NOT EXISTS stg_rp_voucher_hdr_idx1
    ON stg.stg_rp_voucher_hdr USING btree
	(company_code);

CREATE INDEX IF NOT EXISTS stg_rp_voucher_hdr_idx2
    ON stg.stg_rp_voucher_hdr USING btree
	(ou_id, serial_no, doc_type);
	