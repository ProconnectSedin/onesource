-- Table: raw.raw_as_ml_opaccount_dtl

-- DROP TABLE IF EXISTS "raw".raw_as_ml_opaccount_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_as_ml_opaccount_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT raw_as_ml_opaccount_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_as_ml_opaccount_dtl
    OWNER to proconnect;