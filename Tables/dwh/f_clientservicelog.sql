-- Table: dwh.f_clientservicelog

-- DROP TABLE IF EXISTS dwh.f_clientservicelog;

CREATE TABLE IF NOT EXISTS dwh.f_clientservicelog
(
    clientservicelog_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    cust_id integer,
    client_name character varying(50) COLLATE public.nocase,
    service_name character varying(50) COLLATE public.nocase,
    service_type character varying(50) COLLATE public.nocase,
    client_json text COLLATE public.nocase,
    status character varying(50) COLLATE public.nocase,
    error_message text COLLATE public.nocase,
    key_search1 character varying(50) COLLATE public.nocase,
    key_search2 character varying(50) COLLATE public.nocase,
    key_search3 character varying(50) COLLATE public.nocase,
    key_search4 character varying(50) COLLATE public.nocase,
    ip_address character varying(20) COLLATE public.nocase,
    created_date timestamp(3) without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_clientservicelog_pkey PRIMARY KEY (clientservicelog_key),
    CONSTRAINT f_clientservicelog_ukey UNIQUE (cust_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_clientservicelog
    OWNER to proconnect;
-- Index: f_clientservicelog_key_idx

-- DROP INDEX IF EXISTS dwh.f_clientservicelog_key_idx;

CREATE INDEX IF NOT EXISTS f_clientservicelog_key_idx
    ON dwh.f_clientservicelog USING btree
    (cust_id ASC NULLS LAST)
    TABLESPACE pg_default;