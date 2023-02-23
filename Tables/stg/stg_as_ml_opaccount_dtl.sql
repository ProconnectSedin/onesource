-- Table: stg.stg_as_ml_opaccount_dtl

-- DROP TABLE IF EXISTS stg.stg_as_ml_opaccount_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_as_ml_opaccount_dtl
(
    language_id integer NOT NULL,
    opcoa_id character varying(40) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    ml_account_desc character varying(160) COLLATE public.nocase,
    ml_account_desc_shd character varying(160) COLLATE public.nocase,
    "timestamp" integer,
    currency_code character varying(20) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT as_ml_opaccount_dtl_pkey PRIMARY KEY (language_id, opcoa_id, account_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_as_ml_opaccount_dtl
    OWNER to proconnect;
-- Index: stg_as_ml_opaccount_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_as_ml_opaccount_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_as_ml_opaccount_dtl_key_idx2
    ON stg.stg_as_ml_opaccount_dtl USING btree
    (language_id ASC NULLS LAST, opcoa_id COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;