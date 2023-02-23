-- Table: dwh.d_ardusageeventmap

-- DROP TABLE IF EXISTS dwh.d_ardusageeventmap;

CREATE TABLE IF NOT EXISTS dwh.d_ardusageeventmap
(
    ardusageeventmap_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_key bigint,
    company_code character varying(20) COLLATE public.nocase,
    usage_id character varying(40) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    resou_id integer,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_ardusageeventmap_pkey PRIMARY KEY (ardusageeventmap_key),
    CONSTRAINT d_ardusageeventmap_ukey UNIQUE (company_code, usage_id, tran_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_ardusageeventmap
    OWNER to proconnect;
-- Index: d_ardusageeventmap_key_idx

-- DROP INDEX IF EXISTS dwh.d_ardusageeventmap_key_idx;

CREATE INDEX IF NOT EXISTS d_ardusageeventmap_key_idx
    ON dwh.d_ardusageeventmap USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, usage_id COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;