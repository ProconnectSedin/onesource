-- Table: raw.raw_gr_lot_supplot

-- DROP TABLE IF EXISTS "raw".raw_gr_lot_supplot;

CREATE TABLE IF NOT EXISTS "raw".raw_gr_lot_supplot
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pk_grsupplot PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_gr_lot_supplot
    OWNER to proconnect;