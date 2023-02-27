-- Table: stg.stg_ard_customer_account_mst

-- DROP TABLE IF EXISTS stg.stg_ard_customer_account_mst;

CREATE TABLE IF NOT EXISTS stg.stg_ard_customer_account_mst
(
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    customer_group character varying(24) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    currency_code character varying(20) COLLATE public.nocase NOT NULL,
    effective_from timestamp without time zone NOT NULL,
    sequence_no integer NOT NULL,
    timestamps integer NOT NULL,
    custctrl_account character varying(128) COLLATE public.nocase,
    custprepay_account character varying(128) COLLATE public.nocase,
    custnonar_account character varying(128) COLLATE public.nocase,
    effective_to timestamp without time zone,
    resou_id integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ard_customer_account_mst
    OWNER to proconnect;
-- Index: stg_ard_customer_account_mst_key_idx

-- DROP INDEX IF EXISTS stg.stg_ard_customer_account_mst_key_idx;

CREATE INDEX IF NOT EXISTS stg_ard_customer_account_mst_key_idx
    ON stg.stg_ard_customer_account_mst USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, customer_group COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, effective_from ASC NULLS LAST)
    TABLESPACE pg_default;