-- Table: raw.raw_ard_supplier_account_mst

-- DROP TABLE IF EXISTS "raw".raw_ard_supplier_account_mst;

CREATE TABLE IF NOT EXISTS "raw".raw_ard_supplier_account_mst
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    supplier_group character varying(80) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    currency_code character varying(20) COLLATE public.nocase NOT NULL,
    effective_from timestamp without time zone NOT NULL,
    sequence_no integer NOT NULL,
    "timestamp" integer NOT NULL,
    supppay_account character varying(128) COLLATE public.nocase,
    suppprepay_account character varying(128) COLLATE public.nocase,
    suppdeposit_account character varying(128) COLLATE public.nocase,
    effective_to timestamp without time zone,
    resou_id integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_ard_supplier_account_mst_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_ard_supplier_account_mst
    OWNER to proconnect;