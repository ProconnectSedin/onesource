-- Table: raw.raw_adepp_suspension_hdr

-- DROP TABLE IF EXISTS "raw".raw_adepp_suspension_hdr;

CREATE TABLE IF NOT EXISTS "raw".raw_adepp_suspension_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    suspension_no character varying(80) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    suspension_desc character varying(160) COLLATE public.nocase,
    depr_book character varying(80) COLLATE public.nocase,
    susp_start_date timestamp without time zone,
    susp_end_date timestamp without time zone,
    fb_id character varying(80) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT adepp_suspension_hdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_adepp_suspension_hdr
    OWNER to proconnect;