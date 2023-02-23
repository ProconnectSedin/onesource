-- Table: dwh.d_bnkdefcodemst

-- DROP TABLE IF EXISTS dwh.d_bnkdefcodemst;

CREATE TABLE IF NOT EXISTS dwh.d_bnkdefcodemst
(
    bnkdefcodemst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(20) COLLATE public.nocase,
    bank_ref_no character varying(40) COLLATE public.nocase,
    bank_acc_no character varying(40) COLLATE public.nocase,
    bank_code character varying(64) COLLATE public.nocase,
    serial_no integer,
    "timestamp" integer,
    flag character varying(2) COLLATE public.nocase,
    bank_desc character varying(80) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    credit_limit numeric(20,2),
    draw_limit numeric(20,2),
    od_amount numeric(20,2),
    intrate_eff_date timestamp without time zone,
    status character varying(50) COLLATE public.nocase,
    effective_from timestamp without time zone,
    creation_ou integer,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    workflow_status character varying(50) COLLATE public.nocase,
    wfguid character varying(256) COLLATE public.nocase,
    statusml character varying(50) COLLATE public.nocase,
    wfflag character varying(2) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_bnkdefcodemst_pkey PRIMARY KEY (bnkdefcodemst_key),
    CONSTRAINT d_bnkdefcodemst_ukey UNIQUE (company_code, bank_ref_no, bank_acc_no, bank_code, serial_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_bnkdefcodemst
    OWNER to proconnect;
-- Index: d_bnkdefcodemst_key_idx1

-- DROP INDEX IF EXISTS dwh.d_bnkdefcodemst_key_idx1;

CREATE INDEX IF NOT EXISTS d_bnkdefcodemst_key_idx1
    ON dwh.d_bnkdefcodemst USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, bank_ref_no COLLATE public.nocase ASC NULLS LAST, bank_acc_no COLLATE public.nocase ASC NULLS LAST, bank_code COLLATE public.nocase ASC NULLS LAST, serial_no ASC NULLS LAST)
    TABLESPACE pg_default;