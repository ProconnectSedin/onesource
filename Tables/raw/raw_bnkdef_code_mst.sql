-- Table: raw.raw_bnkdef_code_mst

-- DROP TABLE IF EXISTS "raw".raw_bnkdef_code_mst;

CREATE TABLE IF NOT EXISTS "raw".raw_bnkdef_code_mst
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    bank_ref_no character varying(80) COLLATE public.nocase NOT NULL,
    bank_acc_no character varying(80) COLLATE public.nocase NOT NULL,
    bank_code character varying(128) COLLATE public.nocase NOT NULL,
    serial_no integer NOT NULL,
    "timestamp" integer,
    flag character varying(4) COLLATE public.nocase,
    bank_desc character varying(160) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    credit_limit numeric,
    draw_limit numeric,
    od_amount numeric,
    intrate_eff_date timestamp without time zone,
    intrate_od_bal numeric,
    intrate_cr_bal numeric,
    intrate_dr_bal numeric,
    status character varying(100) COLLATE public.nocase,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    creation_ou integer,
    modification_ou character varying(160) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    min_balance numeric,
    min_targeted_bal numeric,
    workflow_status character varying(100) COLLATE public.nocase,
    workflow_error character varying(72) COLLATE public.nocase,
    wfguid character varying(512) COLLATE public.nocase,
    statusml character varying(100) COLLATE public.nocase,
    wfflag character varying(4) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_bnkdef_code_mst_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_bnkdef_code_mst
    OWNER to proconnect;