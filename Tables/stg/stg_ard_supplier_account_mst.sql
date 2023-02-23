-- Table: stg.stg_ard_supplier_account_mst

-- DROP TABLE IF EXISTS stg.stg_ard_supplier_account_mst;

CREATE TABLE IF NOT EXISTS stg.stg_ard_supplier_account_mst
(
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ard_supplier_account_mst
    OWNER to proconnect;