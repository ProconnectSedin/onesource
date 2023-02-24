-- Table: raw.raw_adepp_reverse_hdr

-- DROP TABLE IF EXISTS "raw".raw_adepp_reverse_hdr;

CREATE TABLE IF NOT EXISTS "raw".raw_adepp_reverse_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    rev_doc_no character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    revr_option character varying(80) COLLATE public.nocase,
    depr_proc_runno character varying(80) COLLATE public.nocase NOT NULL,
    depr_total numeric,
    susp_total numeric,
    reversal_date timestamp without time zone,
    fb_id character varying(80) COLLATE public.nocase,
    num_type character varying(40) COLLATE public.nocase,
    rev_status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_adepp_reverse_hdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_adepp_reverse_hdr
    OWNER to proconnect;