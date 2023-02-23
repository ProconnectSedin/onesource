-- Table: dwh.f_griltitemlot

-- DROP TABLE IF EXISTS dwh.f_griltitemlot;

CREATE TABLE IF NOT EXISTS dwh.f_griltitemlot
(
    griltitemlot_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    gr_ilt_ouinstid integer,
    gr_ilt_grno character varying(36) COLLATE public.nocase,
    gr_ilt_grlineno integer,
    gr_ilt_lotno character varying(56) COLLATE public.nocase,
    gr_ilt_suplotrefno integer,
    gr_ilt_quantity numeric(13,2),
    gr_ilt_generatedby character varying(16) COLLATE public.nocase,
    gr_ilt_createdby character varying(60) COLLATE public.nocase,
    gr_ilt_createdate timestamp without time zone,
    gr_ilt_modifiedby character varying(60) COLLATE public.nocase,
    gr_ilt_modifieddate timestamp without time zone,
    gr_ilt_moveno integer,
    gr_ilt_altqty numeric(13,2),
    gr_ilt_altuom character varying(20) COLLATE public.nocase,
    gr_ilt_sublot_app character varying(16) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_griltitemlot_pkey PRIMARY KEY (griltitemlot_key),
    CONSTRAINT f_griltitemlot_ukey UNIQUE (gr_ilt_ouinstid, gr_ilt_grno, gr_ilt_grlineno, gr_ilt_lotno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_griltitemlot
    OWNER to proconnect;
-- Index: f_griltitemlot_key_idx1

-- DROP INDEX IF EXISTS dwh.f_griltitemlot_key_idx1;

CREATE INDEX IF NOT EXISTS f_griltitemlot_key_idx1
    ON dwh.f_griltitemlot USING btree
    (gr_ilt_ouinstid ASC NULLS LAST, gr_ilt_grno COLLATE public.nocase ASC NULLS LAST, gr_ilt_grlineno ASC NULLS LAST, gr_ilt_lotno COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;