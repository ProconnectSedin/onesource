-- Table: stg.stg_gr_sno_serialno

-- DROP TABLE IF EXISTS stg.stg_gr_sno_serialno;

CREATE TABLE IF NOT EXISTS stg.stg_gr_sno_serialno
(
    gr_sno_ouinstid integer NOT NULL,
    gr_sno_grno character varying(72) COLLATE public.nocase NOT NULL,
    gr_sno_grlineno integer NOT NULL,
    gr_sno_lotno character varying(112) COLLATE public.nocase NOT NULL,
    gr_sno_serialno character varying(112) COLLATE public.nocase NOT NULL,
    gr_sno_suplotrefno integer,
    gr_sno_generatedby character varying(32) COLLATE public.nocase,
    gr_sno_createdby character varying(120) COLLATE public.nocase NOT NULL,
    gr_sno_createdate timestamp without time zone NOT NULL,
    gr_sno_modifiedby character varying(120) COLLATE public.nocase NOT NULL,
    gr_sno_modifieddate timestamp without time zone NOT NULL,
    gr_sno_altqty numeric,
    gr_sno_altuom character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_gr_sno_serialno
    OWNER to proconnect;
-- Index: stg_gr_sno_serialno_key_idx2

-- DROP INDEX IF EXISTS stg.stg_gr_sno_serialno_key_idx2;

CREATE INDEX IF NOT EXISTS stg_gr_sno_serialno_key_idx2
    ON stg.stg_gr_sno_serialno USING btree
    (gr_sno_ouinstid ASC NULLS LAST, gr_sno_grno COLLATE public.nocase ASC NULLS LAST, gr_sno_grlineno ASC NULLS LAST, gr_sno_lotno COLLATE public.nocase ASC NULLS LAST, gr_sno_serialno COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;