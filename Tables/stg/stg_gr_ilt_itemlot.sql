-- Table: stg.stg_gr_ilt_itemlot

-- DROP TABLE IF EXISTS stg.stg_gr_ilt_itemlot;

CREATE TABLE IF NOT EXISTS stg.stg_gr_ilt_itemlot
(
    gr_ilt_ouinstid integer NOT NULL,
    gr_ilt_grno character varying(72) COLLATE public.nocase NOT NULL,
    gr_ilt_grlineno integer NOT NULL,
    gr_ilt_lotno character varying(112) COLLATE public.nocase NOT NULL,
    gr_ilt_suplotrefno integer,
    gr_ilt_quantity numeric NOT NULL,
    gr_ilt_generatedby character varying(32) COLLATE public.nocase,
    gr_ilt_createdby character varying(120) COLLATE public.nocase NOT NULL,
    gr_ilt_createdate timestamp without time zone NOT NULL,
    gr_ilt_modifiedby character varying(120) COLLATE public.nocase NOT NULL,
    gr_ilt_modifieddate timestamp without time zone NOT NULL,
    gr_ilt_moveno integer,
    gr_ilt_altqty numeric,
    gr_ilt_altuom character varying(40) COLLATE public.nocase,
    gr_ilt_sublot_app character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_gr_ilt_itemlot
    OWNER to proconnect;
-- Index: stg_gr_ilt_itemlot_key_idx2

-- DROP INDEX IF EXISTS stg.stg_gr_ilt_itemlot_key_idx2;

CREATE INDEX IF NOT EXISTS stg_gr_ilt_itemlot_key_idx2
    ON stg.stg_gr_ilt_itemlot USING btree
    (gr_ilt_ouinstid ASC NULLS LAST, gr_ilt_grno COLLATE public.nocase ASC NULLS LAST, gr_ilt_grlineno ASC NULLS LAST, gr_ilt_lotno COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;