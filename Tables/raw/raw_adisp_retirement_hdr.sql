-- Table: raw.raw_adisp_retirement_hdr

-- DROP TABLE IF EXISTS "raw".raw_adisp_retirement_hdr;

CREATE TABLE IF NOT EXISTS "raw".raw_adisp_retirement_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT raw_adisp_retirement_hdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_adisp_retirement_hdr
    OWNER to proconnect;