-- Table: dwh.f_grlotsupplot

-- DROP TABLE IF EXISTS dwh.f_grlotsupplot;

CREATE TABLE IF NOT EXISTS dwh.f_grlotsupplot
(
    grlotsupplot_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    gr_lot_ouinstid integer,
    gr_lot_grno character varying(36) COLLATE public.nocase,
    gr_lot_grlineno integer,
    gr_lot_refno integer,
    gr_lot_lotno character varying(56) COLLATE public.nocase,
    gr_lot_serialno character varying(56) COLLATE public.nocase,
    gr_lot_mfrdate timestamp without time zone,
    gr_lot_quantity numeric(13,2),
    gr_lot_createdby character varying(60) COLLATE public.nocase,
    gr_lot_createdate timestamp without time zone,
    gr_lot_modifiedby character varying(60) COLLATE public.nocase,
    gr_lot_modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_grlotsupplot_pkey PRIMARY KEY (grlotsupplot_key),
    CONSTRAINT f_grlotsupplot_ukey UNIQUE (gr_lot_ouinstid, gr_lot_grno, gr_lot_grlineno, gr_lot_refno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_grlotsupplot
    OWNER to proconnect;
-- Index: f_grlotsupplot_key_idx1

-- DROP INDEX IF EXISTS dwh.f_grlotsupplot_key_idx1;

CREATE INDEX IF NOT EXISTS f_grlotsupplot_key_idx1
    ON dwh.f_grlotsupplot USING btree
    (gr_lot_ouinstid ASC NULLS LAST, gr_lot_grno COLLATE public.nocase ASC NULLS LAST, gr_lot_grlineno ASC NULLS LAST, gr_lot_refno ASC NULLS LAST)
    TABLESPACE pg_default;