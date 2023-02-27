-- Table: raw.raw_adisp_transfer_hdr

-- DROP TABLE IF EXISTS "raw".raw_adisp_transfer_hdr;

CREATE TABLE IF NOT EXISTS "raw".raw_adisp_transfer_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT raw_adisp_transfer_hdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_adisp_transfer_hdr
    OWNER to proconnect;