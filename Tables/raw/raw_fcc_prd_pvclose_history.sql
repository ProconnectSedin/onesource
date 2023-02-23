-- Table: raw.raw_fcc_prd_pvclose_history

-- DROP TABLE IF EXISTS "raw".raw_fcc_prd_pvclose_history;

CREATE TABLE IF NOT EXISTS "raw".raw_fcc_prd_pvclose_history
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    fin_year character varying(60) COLLATE public.nocase NOT NULL,
    fin_period character varying(60) COLLATE public.nocase NOT NULL,
    bfg_code character varying(80) COLLATE public.nocase NOT NULL,
    serial_no character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    ou_id integer NOT NULL,
    run_no character varying(72) COLLATE public.nocase,
    status character varying(100) COLLATE public.nocase,
    closed_by character varying(120) COLLATE public.nocase,
    closed_date timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_fccprdpvclosehistory_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_fcc_prd_pvclose_history
    OWNER to proconnect;