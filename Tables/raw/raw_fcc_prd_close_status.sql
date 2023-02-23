-- Table: raw.raw_fcc_prd_close_status

-- DROP TABLE IF EXISTS "raw".raw_fcc_prd_close_status;

CREATE TABLE IF NOT EXISTS "raw".raw_fcc_prd_close_status
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    run_no character varying(72) COLLATE public.nocase,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    fin_year character varying(60) COLLATE public.nocase NOT NULL,
    fin_period character varying(60) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    ou_id integer,
    status character varying(100) COLLATE public.nocase,
    closed_by character varying(120) COLLATE public.nocase,
    closed_date timestamp without time zone,
    sequenceno integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    fcc_finprd_startdt timestamp without time zone,
    fcc_finprd_enddt timestamp without time zone,
    fcc_finyr_startdt timestamp without time zone,
    fcc_finyr_enddt timestamp without time zone,
    fcc_finyr_range character varying(100) COLLATE public.nocase,
    fcc_finprd_range character varying(100) COLLATE public.nocase,
    ari_flag character varying(48) COLLATE public.nocase DEFAULT 'N'::character varying,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT f_fccprdclosestatus_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_fcc_prd_close_status
    OWNER to proconnect;