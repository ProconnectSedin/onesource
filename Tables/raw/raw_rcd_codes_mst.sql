-- Table: raw.raw_rcd_codes_mst

-- DROP TABLE IF EXISTS "raw".raw_rcd_codes_mst;

CREATE TABLE IF NOT EXISTS "raw".raw_rcd_codes_mst
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT rcd_codes_mst_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_rcd_codes_mst
    OWNER to proconnect;