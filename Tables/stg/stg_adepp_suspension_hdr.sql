-- Table: stg.stg_adepp_suspension_hdr

-- DROP TABLE IF EXISTS stg.stg_adepp_suspension_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_adepp_suspension_hdr
(
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
    CONSTRAINT adepp_suspension_hdr_pkey PRIMARY KEY (ou_id, suspension_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_adepp_suspension_hdr
    OWNER to proconnect;
-- Index: stg_adepp_suspension_hdr_key_idx

-- DROP INDEX IF EXISTS stg.stg_adepp_suspension_hdr_key_idx;

CREATE INDEX IF NOT EXISTS stg_adepp_suspension_hdr_key_idx
    ON stg.stg_adepp_suspension_hdr USING btree
    (ou_id ASC NULLS LAST, suspension_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;