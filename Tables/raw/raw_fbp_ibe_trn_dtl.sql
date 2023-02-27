-- Table: raw.raw_fbp_ibe_trn_dtl

-- DROP TABLE IF EXISTS "raw".raw_fbp_ibe_trn_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_fbp_ibe_trn_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    fin_year character varying(40) COLLATE public.nocase NOT NULL,
    fin_period character varying(40) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    currency_code character varying(20) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    drcr_flag character varying(24) COLLATE public.nocase,
    base_amount numeric,
    tran_amount numeric,
    batch_id character varying(512) COLLATE public.nocase,
    document_no character varying(72) COLLATE public.nocase,
    tran_type character varying(160) COLLATE public.nocase,
    tran_ou integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    par_base_amount numeric,
    company_code character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_fbp_ibe_trn_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_fbp_ibe_trn_dtl
    OWNER to proconnect;