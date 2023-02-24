-- Table: stg.stg_gr_cpm_consmove

-- DROP TABLE IF EXISTS stg.stg_gr_cpm_consmove;

CREATE TABLE IF NOT EXISTS stg.stg_gr_cpm_consmove
(
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
    CONSTRAINT pk_grconsmove PRIMARY KEY (gr_cpm_grno, gr_cpm_ouinstid, gr_cpm_grlineno, gr_cpm_lineno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_gr_cpm_consmove
    OWNER to proconnect;
-- Index: stg_gr_cpm_consmove_idx

-- DROP INDEX IF EXISTS stg.stg_gr_cpm_consmove_idx;

CREATE INDEX IF NOT EXISTS stg_gr_cpm_consmove_idx
    ON stg.stg_gr_cpm_consmove USING btree
    (gr_cpm_ouinstid ASC NULLS LAST, gr_cpm_grno COLLATE public.nocase ASC NULLS LAST, gr_cpm_grlineno ASC NULLS LAST, gr_cpm_lineno ASC NULLS LAST)
    TABLESPACE pg_default;