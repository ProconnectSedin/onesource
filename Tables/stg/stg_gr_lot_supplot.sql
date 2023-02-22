-- Table: stg.stg_gr_lot_supplot

-- DROP TABLE IF EXISTS stg.stg_gr_lot_supplot;

CREATE TABLE IF NOT EXISTS stg.stg_gr_lot_supplot
(
    gr_lot_ouinstid integer NOT NULL,
    gr_lot_grno character varying(72) COLLATE public.nocase NOT NULL,
    gr_lot_grlineno integer NOT NULL,
    gr_lot_refno integer NOT NULL,
    gr_lot_lotno character varying(112) COLLATE public.nocase NOT NULL,
    gr_lot_sublotno character varying(112) COLLATE public.nocase,
    gr_lot_serialno character varying(112) COLLATE public.nocase,
    gr_lot_mfrdate timestamp without time zone,
    gr_lot_quantity numeric NOT NULL,
    gr_lot_createdby character varying(120) COLLATE public.nocase NOT NULL,
    gr_lot_createdate timestamp without time zone NOT NULL,
    gr_lot_modifiedby character varying(120) COLLATE public.nocase NOT NULL,
    gr_lot_modifieddate timestamp without time zone NOT NULL,
    gr_lot_status character(4) COLLATE public.nocase,
    gr_lot_expdate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_gr_lot_supplot
    OWNER to proconnect;
-- Index: stg_gr_lot_supplot_key_idx2

-- DROP INDEX IF EXISTS stg.stg_gr_lot_supplot_key_idx2;

CREATE INDEX IF NOT EXISTS stg_gr_lot_supplot_key_idx2
    ON stg.stg_gr_lot_supplot USING btree
    (gr_lot_ouinstid ASC NULLS LAST, gr_lot_grno COLLATE public.nocase ASC NULLS LAST, gr_lot_grlineno ASC NULLS LAST, gr_lot_refno ASC NULLS LAST)
    TABLESPACE pg_default;