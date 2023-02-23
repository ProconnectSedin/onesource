-- Table: dwh.d_bnkdefcashmst

-- DROP TABLE IF EXISTS dwh.d_bnkdefcashmst;

CREATE TABLE IF NOT EXISTS dwh.d_bnkdefcashmst
(
    bnkdefcashmst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(20) COLLATE public.nocase,
    cash_code character varying(64) COLLATE public.nocase,
    serial_no integer,
    "timestamp" integer,
    cash_desc character varying(80) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    status character varying(50) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    creation_ou integer,
    modification_ou integer,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_bnkdefcashmst_pkey PRIMARY KEY (bnkdefcashmst_key),
    CONSTRAINT d_bnkdefcashmst_ukey UNIQUE (company_code, cash_code, serial_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_bnkdefcashmst
    OWNER to proconnect;
-- Index: d_bnkdefcashmst_key_idx1

-- DROP INDEX IF EXISTS dwh.d_bnkdefcashmst_key_idx1;

CREATE INDEX IF NOT EXISTS d_bnkdefcashmst_key_idx1
    ON dwh.d_bnkdefcashmst USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, cash_code COLLATE public.nocase ASC NULLS LAST, serial_no ASC NULLS LAST)
    TABLESPACE pg_default;