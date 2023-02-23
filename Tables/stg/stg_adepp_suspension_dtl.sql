-- Table: stg.stg_adepp_suspension_dtl

-- DROP TABLE IF EXISTS stg.stg_adepp_suspension_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_adepp_suspension_dtl
(
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
    CONSTRAINT adepp_suspension_dtl_pkey PRIMARY KEY (ou_id, depr_category, asset_number, tag_number, suspension_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_adepp_suspension_dtl
    OWNER to proconnect;
-- Index: stg_adepp_suspension_dtl_key_idx

-- DROP INDEX IF EXISTS stg.stg_adepp_suspension_dtl_key_idx;

CREATE INDEX IF NOT EXISTS stg_adepp_suspension_dtl_key_idx
    ON stg.stg_adepp_suspension_dtl USING btree
    (ou_id ASC NULLS LAST, suspension_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: stg_adepp_suspension_dtl_key_idx1

-- DROP INDEX IF EXISTS stg.stg_adepp_suspension_dtl_key_idx1;

CREATE INDEX IF NOT EXISTS stg_adepp_suspension_dtl_key_idx1
    ON stg.stg_adepp_suspension_dtl USING btree
    (ou_id ASC NULLS LAST, depr_category COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, suspension_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;