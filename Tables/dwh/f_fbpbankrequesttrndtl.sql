-- Table: dwh.f_fbpbankrequesttrndtl

-- DROP TABLE IF EXISTS dwh.f_fbpbankrequesttrndtl;

CREATE TABLE IF NOT EXISTS dwh.f_fbpbankrequesttrndtl
(
    fbpbankrequesttrndtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    currency_key bigint,
    bankcash_key bigint,
    ou_id integer,
    document_no character varying(36) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    bankcash_code character varying(64) COLLATE public.nocase,
    pay_type character varying(60) COLLATE public.nocase,
    amount_type character varying(80) COLLATE public.nocase,
    "timestamp" integer,
    doc_date timestamp without time zone,
    req_amount numeric(13,2),
    currency_code character varying(10) COLLATE public.nocase,
    doc_user_id character varying(60) COLLATE public.nocase,
    component_id character varying(40) COLLATE public.nocase,
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
    CONSTRAINT f_fbpbankrequesttrndtl_pkey PRIMARY KEY (fbpbankrequesttrndtl_key),
    CONSTRAINT f_fbpbankrequesttrndtl_ukey UNIQUE (ou_id, document_no, fb_id, tran_type, bankcash_code, pay_type, amount_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_fbpbankrequesttrndtl
    OWNER to proconnect;
-- Index: f_fbpbankrequesttrndtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_fbpbankrequesttrndtl_key_idx;

CREATE INDEX IF NOT EXISTS f_fbpbankrequesttrndtl_key_idx
    ON dwh.f_fbpbankrequesttrndtl USING btree
    (ou_id ASC NULLS LAST, document_no COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, bankcash_code COLLATE public.nocase ASC NULLS LAST, pay_type COLLATE public.nocase ASC NULLS LAST, amount_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;