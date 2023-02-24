-- Table: stg.stg_gr_fin_financepost

-- DROP TABLE IF EXISTS stg.stg_gr_fin_financepost;

CREATE TABLE IF NOT EXISTS stg.stg_gr_fin_financepost
(
    gr_fin_ouinstid integer NOT NULL,
    gr_fin_grno character varying(72) COLLATE public.nocase NOT NULL,
    gr_fin_grlineno integer NOT NULL,
    gr_fin_finlineno integer NOT NULL,
    gr_fin_fbpou integer,
    gr_fin_usageid character varying(80) COLLATE public.nocase,
    gr_fin_eventcode character varying(80) COLLATE public.nocase,
    gr_fin_accounttype character varying(40) COLLATE public.nocase,
    gr_fin_drcrflag character(8) COLLATE public.nocase,
    gr_fin_accountcode character varying(128) COLLATE public.nocase,
    gr_fin_tranamount numeric,
    gr_fin_baseamount numeric,
    gr_fin_parbaseamount numeric,
    gr_fin_plbasecurrency character(20) COLLATE public.nocase,
    gr_fin_plbexchgrate numeric,
    gr_fin_createdby character varying(120) COLLATE public.nocase,
    gr_fin_createddate timestamp without time zone,
    gr_fin_modifiedby character varying(120) COLLATE public.nocase,
    gr_fin_modifiedate timestamp without time zone,
    gr_fin_remarks character varying(1020) COLLATE public.nocase,
    gr_fin_projectcode character varying(280) COLLATE public.nocase,
    gr_fin_projectou integer,
    gr_fin_costcenter character varying(128) COLLATE public.nocase,
    gr_fin_analysis_code character(20) COLLATE public.nocase,
    gr_fin_sub_analysiscode character(20) COLLATE public.nocase,
    gr_fin_movelineno integer,
    gr_fin_fbid character varying(80) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pk_grfinancepost PRIMARY KEY (gr_fin_grno, gr_fin_ouinstid, gr_fin_grlineno, gr_fin_finlineno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_gr_fin_financepost
    OWNER to proconnect;
-- Index: stg_gr_fin_financepost_idx

-- DROP INDEX IF EXISTS stg.stg_gr_fin_financepost_idx;

CREATE INDEX IF NOT EXISTS stg_gr_fin_financepost_idx
    ON stg.stg_gr_fin_financepost USING btree
    (gr_fin_ouinstid ASC NULLS LAST, gr_fin_grno COLLATE public.nocase ASC NULLS LAST, gr_fin_grlineno ASC NULLS LAST, gr_fin_finlineno ASC NULLS LAST)
    TABLESPACE pg_default;