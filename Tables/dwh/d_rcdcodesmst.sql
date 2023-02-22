-- Table: dwh.d_rcdcodesmst

-- DROP TABLE IF EXISTS dwh.d_rcdcodesmst;

CREATE TABLE IF NOT EXISTS dwh.d_rcdcodesmst
(
    rcdcodesmst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    component_id character varying(20) COLLATE public.nocase,
    tran_type character varying(20) COLLATE public.nocase,
    event_name character varying(80) COLLATE public.nocase,
    reason_code character varying(20) COLLATE public.nocase,
    "timestamp" integer,
    reason_descr character varying(80) COLLATE public.nocase,
    status character varying(10) COLLATE public.nocase,
    default_flag character varying(10) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    created_lang_id integer,
    event_code character varying(20) COLLATE public.nocase,
    nature_of_reason character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_rcdcodesmst_pkey PRIMARY KEY (rcdcodesmst_key),
    CONSTRAINT d_rcdcodesmst_ukey UNIQUE (component_id, tran_type, event_name, reason_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_rcdcodesmst
    OWNER to proconnect;
-- Index: d_rcdcodesmst_key_idx1

-- DROP INDEX IF EXISTS dwh.d_rcdcodesmst_key_idx1;

CREATE INDEX IF NOT EXISTS d_rcdcodesmst_key_idx1
    ON dwh.d_rcdcodesmst USING btree
    (component_id COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, event_name COLLATE public.nocase ASC NULLS LAST, reason_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;