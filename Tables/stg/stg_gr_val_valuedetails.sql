-- Table: stg.stg_gr_val_valuedetails

-- DROP TABLE IF EXISTS stg.stg_gr_val_valuedetails;

CREATE TABLE IF NOT EXISTS stg.stg_gr_val_valuedetails
(
    gr_val_ouinstid integer NOT NULL,
    gr_val_grno character varying(72) COLLATE public.nocase NOT NULL,
    gr_val_grlineno integer NOT NULL,
    gr_val_cost numeric,
    gr_val_costper numeric,
    gr_val_stdcost numeric,
    gr_val_accunit character varying(80) COLLATE public.nocase,
    gr_val_acusage character varying(80) COLLATE public.nocase,
    gr_val_analycode character(20) COLLATE public.nocase,
    gr_val_sanalycode character(20) COLLATE public.nocase,
    gr_val_linetcdvalue numeric,
    gr_val_lineotcdvalue numeric,
    gr_val_doctcdstkvalue numeric,
    gr_val_linetcdstkvalue numeric,
    gr_val_createdby character varying(120) COLLATE public.nocase,
    gr_val_createdate timestamp without time zone,
    gr_val_modifiedby character varying(120) COLLATE public.nocase,
    gr_val_modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_gr_val_valuedetails
    OWNER to proconnect;
-- Index: stg_gr_val_valuedetails_key_idx2

-- DROP INDEX IF EXISTS stg.stg_gr_val_valuedetails_key_idx2;

CREATE INDEX IF NOT EXISTS stg_gr_val_valuedetails_key_idx2
    ON stg.stg_gr_val_valuedetails USING btree
    (gr_val_ouinstid ASC NULLS LAST, gr_val_grno COLLATE public.nocase ASC NULLS LAST, gr_val_grlineno ASC NULLS LAST)
    TABLESPACE pg_default;