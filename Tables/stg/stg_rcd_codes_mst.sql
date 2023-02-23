-- Table: stg.stg_rcd_codes_mst

-- DROP TABLE IF EXISTS stg.stg_rcd_codes_mst;

CREATE TABLE IF NOT EXISTS stg.stg_rcd_codes_mst
(
    component_id character varying(40) COLLATE public.nocase NOT NULL,
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    event_name character varying(160) COLLATE public.nocase NOT NULL,
    reason_code character varying(40) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    reason_descr character varying(160) COLLATE public.nocase,
    status character varying(4) COLLATE public.nocase,
    default_flag character varying(4) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    created_lang_id integer,
    event_code character varying(24) COLLATE public.nocase,
    nature_of_reason character varying COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT rcd_codes_mst_pkey UNIQUE (component_id, tran_type, event_name, reason_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_rcd_codes_mst
    OWNER to proconnect;
-- Index: stg_rcd_codes_mst_key_idx2

-- DROP INDEX IF EXISTS stg.stg_rcd_codes_mst_key_idx2;

CREATE INDEX IF NOT EXISTS stg_rcd_codes_mst_key_idx2
    ON stg.stg_rcd_codes_mst USING btree
    (component_id COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, event_name COLLATE public.nocase ASC NULLS LAST, reason_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;