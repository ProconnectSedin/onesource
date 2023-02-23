-- Table: stg.stg_emod_bu_ou_fb_map

-- DROP TABLE IF EXISTS stg.stg_emod_bu_ou_fb_map;

CREATE TABLE IF NOT EXISTS stg.stg_emod_bu_ou_fb_map
(
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    ou_id integer NOT NULL,
    bu_id character varying(80) COLLATE public.nocase NOT NULL,
    serial_no integer NOT NULL,
    "timestamp" integer,
    map_by character varying(120) COLLATE public.nocase,
    map_date timestamp without time zone,
    unmap_by character varying(120) COLLATE public.nocase,
    unmap_date timestamp without time zone,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    map_status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT emod_bu_ou_fb_map_pkey PRIMARY KEY (fb_id, ou_id, bu_id, serial_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_emod_bu_ou_fb_map
    OWNER to proconnect;