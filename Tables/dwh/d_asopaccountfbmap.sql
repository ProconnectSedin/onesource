-- Table: dwh.d_asopaccountfbmap

-- DROP TABLE IF EXISTS dwh.d_asopaccountfbmap;

CREATE TABLE IF NOT EXISTS dwh.d_asopaccountfbmap
(
    asopaccountfbmap_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_key bigint,
    acc_key bigint,
    opcoa_id character varying(20) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    map_status character varying(10) COLLATE public.nocase,
    resou_id integer,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_asopaccountfbmap_pkey PRIMARY KEY (asopaccountfbmap_key),
    CONSTRAINT d_asopaccountfbmap_ukey UNIQUE (opcoa_id, account_code, company_code, fb_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_asopaccountfbmap
    OWNER to proconnect;
-- Index: d_asopaccountfbmap_key_idx

-- DROP INDEX IF EXISTS dwh.d_asopaccountfbmap_key_idx;

CREATE INDEX IF NOT EXISTS d_asopaccountfbmap_key_idx
    ON dwh.d_asopaccountfbmap USING btree
    (opcoa_id COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;