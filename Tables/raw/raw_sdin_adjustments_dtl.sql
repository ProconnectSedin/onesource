-- Table: raw.raw_sdin_adjustments_dtl

-- DROP TABLE IF EXISTS "raw".raw_sdin_adjustments_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_sdin_adjustments_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    ref_doc_type character varying(40) COLLATE public.nocase NOT NULL,
    ref_doc_no character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    ref_doc_date timestamp without time zone,
    ref_doc_fb_id character varying(80) COLLATE public.nocase,
    ref_doc_amount numeric,
    ref_doc_current_os numeric,
    ref_doc_supp_ou integer,
    guid character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    supp_doc_no character varying(72) COLLATE public.nocase,
    project_code character varying(72) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    ref_doc_adjamt numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_sdin_adjustments_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_sdin_adjustments_dtl
    OWNER to proconnect;