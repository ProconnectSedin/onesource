-- Table: raw.raw_fbp_bank_request_trn_dtl

-- DROP TABLE IF EXISTS "raw".raw_fbp_bank_request_trn_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_fbp_bank_request_trn_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    document_no character varying(72) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    tran_type character varying(160) COLLATE public.nocase NOT NULL,
    bankcash_code character varying(128) COLLATE public.nocase NOT NULL,
    pay_type character varying(120) COLLATE public.nocase NOT NULL,
    amount_type character varying(160) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    doc_date timestamp without time zone,
    req_amount numeric,
    currency_code character varying(20) COLLATE public.nocase,
    doc_user_id character varying(120) COLLATE public.nocase,
    component_id character varying(80) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_fbp_bank_request_trn_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_fbp_bank_request_trn_dtl
    OWNER to proconnect;