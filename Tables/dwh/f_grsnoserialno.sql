-- Table: dwh.f_grsnoserialno

-- DROP TABLE IF EXISTS dwh.f_grsnoserialno;

CREATE TABLE IF NOT EXISTS dwh.f_grsnoserialno
(
    grsnoserialno_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    gr_sno_ouinstid integer,
    gr_sno_grno character varying(36) COLLATE public.nocase,
    gr_sno_grlineno integer,
    gr_sno_lotno character varying(56) COLLATE public.nocase,
    gr_sno_serialno character varying(56) COLLATE public.nocase,
    gr_sno_suplotrefno integer,
    gr_sno_generatedby character varying(16) COLLATE public.nocase,
    gr_sno_createdby character varying(60) COLLATE public.nocase,
    gr_sno_createdate timestamp without time zone,
    gr_sno_modifiedby character varying(60) COLLATE public.nocase,
    gr_sno_modifieddate timestamp without time zone,
    gr_sno_altuom character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_grsnoserialno_pkey PRIMARY KEY (grsnoserialno_key),
    CONSTRAINT f_grsnoserialno_ukey UNIQUE (gr_sno_ouinstid, gr_sno_grno, gr_sno_grlineno, gr_sno_lotno, gr_sno_serialno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_grsnoserialno
    OWNER to proconnect;
-- Index: f_grsnoserialno_key_idx1

-- DROP INDEX IF EXISTS dwh.f_grsnoserialno_key_idx1;

CREATE INDEX IF NOT EXISTS f_grsnoserialno_key_idx1
    ON dwh.f_grsnoserialno USING btree
    (gr_sno_ouinstid ASC NULLS LAST, gr_sno_grno COLLATE public.nocase ASC NULLS LAST, gr_sno_grlineno ASC NULLS LAST, gr_sno_lotno COLLATE public.nocase ASC NULLS LAST, gr_sno_serialno COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;