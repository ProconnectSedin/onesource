-- Table: raw.raw_gr_ilt_itemlot

-- DROP TABLE IF EXISTS "raw".raw_gr_ilt_itemlot;

CREATE TABLE IF NOT EXISTS "raw".raw_gr_ilt_itemlot
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pk_gritemlot PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_gr_ilt_itemlot
    OWNER to proconnect;