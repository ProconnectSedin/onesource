-- Table: raw.raw_sdin_apportioned_tcd_dtl

-- DROP TABLE IF EXISTS "raw".raw_sdin_apportioned_tcd_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_sdin_apportioned_tcd_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    line_no integer NOT NULL,
    item_tcd_code character varying(128) COLLATE public.nocase NOT NULL,
    item_tcd_var character varying(128) COLLATE public.nocase NOT NULL,
    tcd_version integer NOT NULL,
    "timestamp" integer NOT NULL,
    item_type character varying(12) COLLATE public.nocase,
    tcd_rate numeric,
    taxable_amt numeric,
    tcd_amount numeric,
    tcd_currency character varying(20) COLLATE public.nocase,
    base_amount numeric,
    par_base_amount numeric,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT sdin_apportioned_tcd_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_sdin_apportioned_tcd_dtl
    OWNER to proconnect;