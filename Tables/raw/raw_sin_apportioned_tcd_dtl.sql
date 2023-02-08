CREATE TABLE IF NOT EXISTS "raw".raw_sin_apportioned_tcd_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(36) COLLATE public.nocase,
    line_no integer,
    item_tcd_code character varying(64) COLLATE public.nocase,
    item_tcd_var character varying(64) COLLATE public.nocase,
    tcd_version integer,
    "timestamp" integer,
    item_type character varying(10) COLLATE public.nocase,
    tcd_rate numeric(20,2),
    taxable_amt numeric(20,2),
    tcd_amount numeric(20,2),
    tcd_currency character varying(10) COLLATE public.nocase,
    base_amount numeric(20,2),
    par_base_amount numeric(20,2),
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE pg_catalog."default",
    subanalysis_code character varying(10) COLLATE pg_catalog."default",
    remarks character varying(100) COLLATE pg_catalog."default",
    createdby character varying(120) COLLATE pg_catalog."default",
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE pg_catalog."default",
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone
)