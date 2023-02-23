-- Table: raw.raw_adepp_suspension_dtl

-- DROP TABLE IF EXISTS "raw".raw_adepp_suspension_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_adepp_suspension_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    depr_category character varying(160) COLLATE public.nocase NOT NULL,
    asset_number character varying(72) COLLATE public.nocase NOT NULL,
    tag_number integer NOT NULL,
    suspension_no character varying(80) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    cost_center character varying(40) COLLATE public.nocase,
    asset_location character varying(80) COLLATE public.nocase,
    susp_start_date timestamp without time zone,
    susp_end_date timestamp without time zone,
    status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT adepp_suspension_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_adepp_suspension_dtl
    OWNER to proconnect;