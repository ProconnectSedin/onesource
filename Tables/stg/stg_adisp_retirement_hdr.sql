-- Table: stg.stg_adisp_retirement_hdr

-- DROP TABLE IF EXISTS stg.stg_adisp_retirement_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_adisp_retirement_hdr
(
    ou_id integer NOT NULL,
    retirement_number character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    retirement_date timestamp without time zone,
    fb_id character varying(80) COLLATE public.nocase,
    num_type character varying(40) COLLATE public.nocase,
    pay_category character varying(160) COLLATE public.nocase,
    proposal_number character varying(72) COLLATE public.nocase,
    gen_auth_invoice character varying(40) COLLATE public.nocase,
    retirement_status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    num_type_cdi character varying(40) COLLATE public.nocase,
    workflow_status character varying(100) COLLATE public.nocase,
    workflow_error character varying(72) COLLATE public.nocase,
    wf_guid character varying(512) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT adisp_retirement_hdr_pkey PRIMARY KEY (ou_id, retirement_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_adisp_retirement_hdr
    OWNER to proconnect;
-- Index: stg_adisp_retirement_hdr_idx

-- DROP INDEX IF EXISTS stg.stg_adisp_retirement_hdr_idx;

CREATE INDEX IF NOT EXISTS stg_adisp_retirement_hdr_idx
    ON stg.stg_adisp_retirement_hdr USING btree
    (ou_id ASC NULLS LAST, retirement_number COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;