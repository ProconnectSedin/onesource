-- Table: raw.raw_pt_payterm_master

-- DROP TABLE IF EXISTS "raw".raw_pt_payterm_master;

CREATE TABLE IF NOT EXISTS "raw".raw_pt_payterm_master
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    pt_ouinstance integer NOT NULL,
    pt_paytermcode character varying(72) COLLATE public.nocase NOT NULL,
    pt_version_no integer NOT NULL,
    pt_description character varying(600) COLLATE public.nocase,
    pt_effectivedate timestamp without time zone,
    pt_expirydate timestamp without time zone,
    pt_status character varying(32) COLLATE public.nocase,
    pt_propdiscount character(8) COLLATE public.nocase NOT NULL,
    pt_anchordateinfo character varying(32) COLLATE public.nocase,
    pt_remarks character varying(1020) COLLATE public.nocase,
    pt_created_by character varying(120) COLLATE public.nocase,
    pt_created_date timestamp without time zone,
    pt_modified_by character varying(120) COLLATE public.nocase,
    pt_modified_date timestamp without time zone,
    pt_timestamp_value integer,
    pt_lo_id character varying(80) COLLATE public.nocase NOT NULL,
    pt_created_langid integer NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_pt_payterm_master_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_pt_payterm_master
    OWNER to proconnect;