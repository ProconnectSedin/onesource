-- Table: dwh.d_aloclocationmst

-- DROP TABLE IF EXISTS dwh.d_aloclocationmst;

CREATE TABLE IF NOT EXISTS dwh.d_aloclocationmst
(
    aloclocationmst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    loc_code character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    ou_id integer,
    loc_desc character varying(80) COLLATE public.nocase,
    loc_abbr character varying(150) COLLATE public.nocase,
    parentloc_code character varying(40) COLLATE public.nocase,
    loc_type character varying(80) COLLATE public.nocase,
    loc_status character varying(50) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    workflow_status character varying(50) COLLATE public.nocase,
    workflow_error character varying(40) COLLATE public.nocase,
    wf_flag character varying(30) COLLATE public.nocase,
    guid character varying(256) COLLATE public.nocase,
    latitude numeric(25,2),
    longitude numeric(25,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_aloclocationmst_pkey PRIMARY KEY (aloclocationmst_key),
    CONSTRAINT d_aloclocationmst_ukey UNIQUE (loc_code, ou_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_aloclocationmst
    OWNER to proconnect;
-- Index: d_aloclocationmst_key_idx

-- DROP INDEX IF EXISTS dwh.d_aloclocationmst_key_idx;

CREATE INDEX IF NOT EXISTS d_aloclocationmst_key_idx
    ON dwh.d_aloclocationmst USING btree
    (loc_code COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST)
    TABLESPACE pg_default;