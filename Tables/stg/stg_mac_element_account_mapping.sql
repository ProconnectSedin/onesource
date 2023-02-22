-- Table: stg.stg_mac_element_account_mapping

-- DROP TABLE IF EXISTS stg.stg_mac_element_account_mapping;

CREATE TABLE IF NOT EXISTS stg.stg_mac_element_account_mapping
(
    ou_id integer NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    ma_element_no character varying(128) COLLATE public.nocase NOT NULL,
    ma_account_no character varying(128) COLLATE public.nocase NOT NULL,
    ma_user_id integer NOT NULL,
    ma_datetime timestamp without time zone NOT NULL,
    ma_timestamp integer,
    ma_createdby character varying(160) COLLATE public.nocase,
    ma_createdate timestamp without time zone,
    ma_modifedby character varying(160) COLLATE public.nocase,
    ma_modifydate timestamp without time zone,
    bu_id character varying(80) COLLATE public.nocase,
    lo_id character varying(80) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_mac_element_account_mapping
    OWNER to proconnect;
-- Index: stg_mac_element_account_mapping_key_idx2

-- DROP INDEX IF EXISTS stg.stg_mac_element_account_mapping_key_idx2;

CREATE INDEX IF NOT EXISTS stg_mac_element_account_mapping_key_idx2
    ON stg.stg_mac_element_account_mapping USING btree
    (ou_id ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, ma_element_no COLLATE public.nocase ASC NULLS LAST, ma_account_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;