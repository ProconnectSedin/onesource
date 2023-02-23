-- Table: dwh.f_cbadjadjvcrdocref

-- DROP TABLE IF EXISTS dwh.f_cbadjadjvcrdocref;

CREATE TABLE IF NOT EXISTS dwh.f_cbadjadjvcrdocref
(
    cbadjadjvcrdocref_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    adj_docdtl_key bigint,
    parent_key character varying(260) COLLATE public.nocase,
    ref_cr_doc_no character varying(40) COLLATE public.nocase,
    cr_doc_ou integer,
    cr_doc_type character varying(80) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    cr_doc_adj_amt numeric(25,2),
    cr_doc_unadj_amt numeric(25,2),
    tran_type character varying(80) COLLATE public.nocase,
    guid character varying(260) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_cbadjadjvcrdocref_pkey PRIMARY KEY (cbadjadjvcrdocref_key),
    CONSTRAINT f_cbadjadjvcrdocref_ukey UNIQUE (parent_key, ref_cr_doc_no, cr_doc_ou, cr_doc_type, term_no),
    CONSTRAINT f_cbadjadjvcrdocdtl_fkey FOREIGN KEY (adj_docdtl_key)
        REFERENCES dwh.f_cbadjadjvcrdocdtl (adj_docdtl_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cbadjadjvcrdocref
    OWNER to proconnect;
-- Index: f_cbadjadjvcrdocref_key_idx

-- DROP INDEX IF EXISTS dwh.f_cbadjadjvcrdocref_key_idx;

CREATE INDEX IF NOT EXISTS f_cbadjadjvcrdocref_key_idx
    ON dwh.f_cbadjadjvcrdocref USING btree
    (parent_key COLLATE public.nocase ASC NULLS LAST, ref_cr_doc_no COLLATE public.nocase ASC NULLS LAST, cr_doc_ou ASC NULLS LAST, cr_doc_type COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;