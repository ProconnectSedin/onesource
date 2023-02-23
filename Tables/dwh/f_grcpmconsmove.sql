-- Table: dwh.f_grcpmconsmove

-- DROP TABLE IF EXISTS dwh.f_grcpmconsmove;

CREATE TABLE IF NOT EXISTS dwh.f_grcpmconsmove
(
    gr_cpm_consmove_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    gr_cpm_ouinstid integer,
    gr_cpm_grno character varying(36) COLLATE public.nocase,
    gr_cpm_grlineno integer,
    gr_cpm_lineno integer,
    gr_cpm_status character varying(10) COLLATE public.nocase,
    gr_cpm_movedqty numeric(13,2),
    gr_cpm_ccusage character varying(40) COLLATE public.nocase,
    gr_cpm_wotype character varying(80) COLLATE public.nocase,
    gr_cpm_createdby character varying(60) COLLATE public.nocase,
    gr_cpm_createdate timestamp without time zone,
    gr_cpm_modifiedby character varying(60) COLLATE public.nocase,
    gr_cpm_modifieddate timestamp without time zone,
    gr_cpm_acusage character varying(40) COLLATE public.nocase,
    gr_cpm_remarks character varying(2000) COLLATE public.nocase,
    gr_cpm_ordsubsch_no integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_grcpmconsmove_pkey PRIMARY KEY (gr_cpm_consmove_key),
    CONSTRAINT f_grcpmconsmove_ukey UNIQUE (gr_cpm_ouinstid, gr_cpm_grno, gr_cpm_grlineno, gr_cpm_lineno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_grcpmconsmove
    OWNER to proconnect;