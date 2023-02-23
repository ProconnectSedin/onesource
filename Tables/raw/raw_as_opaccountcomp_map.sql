-- Table: raw.raw_as_opaccountcomp_map

-- DROP TABLE IF EXISTS "raw".raw_as_opaccountcomp_map;

CREATE TABLE IF NOT EXISTS "raw".raw_as_opaccountcomp_map
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    opcoa_id character varying(40) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    map_status character varying(8) COLLATE public.nocase,
    resou_id integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_as_opaccountcomp_map_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_as_opaccountcomp_map
    OWNER to proconnect;