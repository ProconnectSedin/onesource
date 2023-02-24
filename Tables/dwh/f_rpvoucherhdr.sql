-- Table: dwh.f_rpvoucherhdr

-- DROP TABLE IF EXISTS dwh.f_rpvoucherhdr;

CREATE TABLE IF NOT EXISTS dwh.f_rpvoucherhdr
(
    rpvoucherhdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    companycode_key bigint,
    bankcode_key bigint,
    ou_id integer,
    serial_no integer,
    doc_type character varying(24) COLLATE public.nocase,
    "timestamp" integer,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    company_code character varying(20) COLLATE public.nocase,
    bank_acc_no character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_rpvoucherhdr_pkey PRIMARY KEY (rpvoucherhdr_key),
    CONSTRAINT f_rpvoucherhdr_ukey UNIQUE (ou_id, serial_no, doc_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_rpvoucherhdr
    OWNER to proconnect;
-- Index: f_rpvoucherhdr_key_idx

-- DROP INDEX IF EXISTS dwh.f_rpvoucherhdr_key_idx;

CREATE INDEX IF NOT EXISTS f_rpvoucherhdr_key_idx
    ON dwh.f_rpvoucherhdr USING btree
    (ou_id ASC NULLS LAST, serial_no ASC NULLS LAST, doc_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;