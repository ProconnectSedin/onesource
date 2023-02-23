-- Table: raw.raw_rp_voucher_hdr

-- DROP TABLE IF EXISTS "raw".raw_rp_voucher_hdr;

CREATE TABLE IF NOT EXISTS "raw".raw_rp_voucher_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT raw_rp_voucher_hdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_rp_voucher_hdr
    OWNER to proconnect;