-- Table: stg.stg_adisp_transfer_hdr

-- DROP TABLE IF EXISTS stg.stg_adisp_transfer_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_adisp_transfer_hdr
(
    ou_id integer NOT NULL,
    transfer_number character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    transfer_date timestamp without time zone,
    transfer_status character varying(100) COLLATE public.nocase,
    num_type character varying(40) COLLATE public.nocase,
    source_fb_id character varying(80) COLLATE public.nocase,
    destination_fb_id character varying(80) COLLATE public.nocase,
    confirmation_date timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    transfer_in_no character varying(72) COLLATE public.nocase,
    tcal_status_in character varying(48) COLLATE public.nocase,
    tcal_status character varying(48) COLLATE public.nocase,
    tran_type character varying(100) COLLATE public.nocase,
    transfer_in_status character varying(100) COLLATE public.nocase,
    transfer_in_numtyp character varying(40) COLLATE public.nocase,
    workflow_status character varying(100) COLLATE public.nocase,
    workflow_error character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT adisp_transfer_hdr_pkey PRIMARY KEY (ou_id, transfer_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_adisp_transfer_hdr
    OWNER to proconnect;
-- Index: stg_adisp_transfer_hdr_idx

-- DROP INDEX IF EXISTS stg.stg_adisp_transfer_hdr_idx;

CREATE INDEX IF NOT EXISTS stg_adisp_transfer_hdr_idx
    ON stg.stg_adisp_transfer_hdr USING btree
    (ou_id ASC NULLS LAST, transfer_number COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;