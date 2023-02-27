-- Table: dwh.f_sadadjvdrdocref

-- DROP TABLE IF EXISTS dwh.f_sadadjvdrdocref;

CREATE TABLE IF NOT EXISTS dwh.f_sadadjvdrdocref
(
    sadadjvdrdocref_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    sadadjvdrdocdtl_key bigint NOT NULL,
    parent_key character varying(260) COLLATE public.nocase,
    ref_dr_doc_no character varying(40) COLLATE public.nocase,
    dr_doc_ou integer,
    dr_doc_type character varying(80) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    dr_doc_adj_amt numeric(13,2),
    dr_doc_unadj_amt numeric(13,2),
    tran_type character varying(80) COLLATE public.nocase,
    discount numeric(13,2),
    guid character varying(260) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_sadadjvdrdocref_pkey PRIMARY KEY (sadadjvdrdocref_key),
    CONSTRAINT f_sadadjvdrdocref_ukey UNIQUE (parent_key, ref_dr_doc_no, dr_doc_ou, dr_doc_type, term_no),
    CONSTRAINT f_sadadjvdrdocref_sadadjvdrdocdtl_key_fkey FOREIGN KEY (sadadjvdrdocdtl_key)
        REFERENCES dwh.f_sadadjvdrdocdtl (sadadjvdrdocdtl_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_sadadjvdrdocref
    OWNER to proconnect;
-- Index: f_sadadjvdrdocref_key_idx1

-- DROP INDEX IF EXISTS dwh.f_sadadjvdrdocref_key_idx1;

CREATE INDEX IF NOT EXISTS f_sadadjvdrdocref_key_idx1
    ON dwh.f_sadadjvdrdocref USING btree
    (parent_key COLLATE public.nocase ASC NULLS LAST, ref_dr_doc_no COLLATE public.nocase ASC NULLS LAST, dr_doc_ou ASC NULLS LAST, dr_doc_type COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;