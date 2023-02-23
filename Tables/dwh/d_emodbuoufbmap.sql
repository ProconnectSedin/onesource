-- Table: dwh.d_emodbuoufbmap

-- DROP TABLE IF EXISTS dwh.d_emodbuoufbmap;

CREATE TABLE IF NOT EXISTS dwh.d_emodbuoufbmap
(
    emodbuoufbmap_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    fb_id character varying(40) COLLATE public.nocase,
    ou_id integer,
    bu_id character varying(40) COLLATE public.nocase,
    serial_no integer,
    "timestamp" integer,
    map_by character varying(60) COLLATE public.nocase,
    map_date timestamp without time zone,
    effective_from timestamp without time zone,
    map_status character varying(50) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_emodbuoufbmap_pkey PRIMARY KEY (emodbuoufbmap_key),
    CONSTRAINT d_emodbuoufbmap_ukey UNIQUE (fb_id, ou_id, bu_id, serial_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_emodbuoufbmap
    OWNER to proconnect;