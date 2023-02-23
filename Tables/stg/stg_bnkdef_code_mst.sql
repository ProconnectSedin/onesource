-- Table: stg.stg_bnkdef_code_mst

-- DROP TABLE IF EXISTS stg.stg_bnkdef_code_mst;

CREATE TABLE IF NOT EXISTS stg.stg_bnkdef_code_mst
(
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
    CONSTRAINT bnkdef_code_mst_pkey PRIMARY KEY (company_code, bank_ref_no, bank_acc_no, bank_code, serial_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_bnkdef_code_mst
    OWNER to proconnect;
-- Index: stg_bnkdef_code_mst_key_idx2

-- DROP INDEX IF EXISTS stg.stg_bnkdef_code_mst_key_idx2;

CREATE INDEX IF NOT EXISTS stg_bnkdef_code_mst_key_idx2
    ON stg.stg_bnkdef_code_mst USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, bank_ref_no COLLATE public.nocase ASC NULLS LAST, bank_acc_no COLLATE public.nocase ASC NULLS LAST, bank_code COLLATE public.nocase ASC NULLS LAST, serial_no ASC NULLS LAST)
    TABLESPACE pg_default;