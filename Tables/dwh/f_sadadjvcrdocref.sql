-- Table: dwh.f_sadadjvcrdocref

-- DROP TABLE IF EXISTS dwh.f_sadadjvcrdocref;

CREATE TABLE IF NOT EXISTS dwh.f_sadadjvcrdocref
(
    sadadjvcrdocref_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    sadadjvcrdocdtl_key bigint NOT NULL,
    parent_key character varying(260) COLLATE public.nocase,
    ref_cr_doc_no character varying(40) COLLATE public.nocase,
    cr_doc_ou integer,
    cr_doc_type character varying(80) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    sale_ord_ref character varying(40) COLLATE public.nocase,
    cr_doc_adj_amt numeric(13,2),
    au_cr_doc_unadj_amt numeric(13,2),
    tran_type character varying(80) COLLATE public.nocase,
    cross_cur_erate numeric(13,2),
    cr_discount numeric(13,2),
    guid character varying(260) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_sadadjvcrdocref_pkey PRIMARY KEY (sadadjvcrdocref_key),
    CONSTRAINT f_sadadjvcrdocref_ukey UNIQUE (parent_key, ref_cr_doc_no, cr_doc_ou, cr_doc_type, term_no),
    CONSTRAINT f_sadadjvcrdocref_sadadjvcrdocdtl_key_fkey FOREIGN KEY (sadadjvcrdocdtl_key)
        REFERENCES dwh.f_sadadjvcrdocdtl (sadadjvcrdocdtl_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_sadadjvcrdocref
    OWNER to proconnect;
-- Index: f_sadadjvcrdocref_key_idx1

-- DROP INDEX IF EXISTS dwh.f_sadadjvcrdocref_key_idx1;

CREATE INDEX IF NOT EXISTS f_sadadjvcrdocref_key_idx1
    ON dwh.f_sadadjvcrdocref USING btree
    (parent_key COLLATE public.nocase ASC NULLS LAST, ref_cr_doc_no COLLATE public.nocase ASC NULLS LAST, cr_doc_ou ASC NULLS LAST, cr_doc_type COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;