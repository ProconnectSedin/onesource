-- Table: raw.raw_gr_cpm_consmove

-- DROP TABLE IF EXISTS "raw".raw_gr_cpm_consmove;

CREATE TABLE IF NOT EXISTS "raw".raw_gr_cpm_consmove
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    gr_cpm_ouinstid integer NOT NULL,
    gr_cpm_grno character varying(72) COLLATE public.nocase NOT NULL,
    gr_cpm_grlineno integer NOT NULL,
    gr_cpm_lineno integer NOT NULL,
    gr_cpm_status character(8) COLLATE public.nocase,
    gr_cpm_movedqty numeric NOT NULL,
    gr_cpm_ccusage character varying(80) COLLATE public.nocase NOT NULL,
    gr_cpm_moveto character varying(64) COLLATE public.nocase,
    gr_cpm_wotype character varying(160) COLLATE public.nocase,
    gr_cpm_woorderno character varying(72) COLLATE public.nocase,
    gr_cpm_woorderlineno integer,
    gr_cpm_createdby character varying(120) COLLATE public.nocase NOT NULL,
    gr_cpm_createdate timestamp without time zone NOT NULL,
    gr_cpm_modifiedby character varying(120) COLLATE public.nocase NOT NULL,
    gr_cpm_modifieddate timestamp without time zone NOT NULL,
    gr_cpm_altuom character varying(40) COLLATE public.nocase,
    gr_cpm_altqty numeric,
    gr_cpm_acusage character varying(80) COLLATE public.nocase,
    gr_cpm_analysiscode character(20) COLLATE public.nocase,
    gr_cpm_subanalysiscode character(20) COLLATE public.nocase,
    gr_cpm_remarks character varying(4000) COLLATE public.nocase,
    gr_cpm_costcenter character varying(128) COLLATE public.nocase,
    gr_cpm_ordsubsch_no integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_gr_cpm_consmove_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_gr_cpm_consmove
    OWNER to proconnect;