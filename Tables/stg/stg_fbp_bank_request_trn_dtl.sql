-- Table: stg.stg_fbp_bank_request_trn_dtl

-- DROP TABLE IF EXISTS stg.stg_fbp_bank_request_trn_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_fbp_bank_request_trn_dtl
(
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
    CONSTRAINT fbp_bank_request_trn_dtl_pkey PRIMARY KEY (ou_id, document_no, fb_id, tran_type, bankcash_code, pay_type, amount_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_fbp_bank_request_trn_dtl
    OWNER to proconnect;
-- Index: stg_fbp_bank_request_trn_dtl_idx

-- DROP INDEX IF EXISTS stg.stg_fbp_bank_request_trn_dtl_idx;

CREATE INDEX IF NOT EXISTS stg_fbp_bank_request_trn_dtl_idx
    ON stg.stg_fbp_bank_request_trn_dtl USING btree
    (ou_id ASC NULLS LAST, document_no COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, bankcash_code COLLATE public.nocase ASC NULLS LAST, pay_type COLLATE public.nocase ASC NULLS LAST, amount_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: stg_fbp_bank_request_trn_dtl_idx1

-- DROP INDEX IF EXISTS stg.stg_fbp_bank_request_trn_dtl_idx1;

CREATE INDEX IF NOT EXISTS stg_fbp_bank_request_trn_dtl_idx1
    ON stg.stg_fbp_bank_request_trn_dtl USING btree
    (bankcash_code COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, "timestamp" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS stg_fbp_bank_request_trn_dtl_idx2
    ON stg.stg_fbp_bank_request_trn_dtl USING btree
	(currency_code);