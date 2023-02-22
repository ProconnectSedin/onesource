-- Table: raw.raw_gr_val_valuedetails

-- DROP TABLE IF EXISTS "raw".raw_gr_val_valuedetails;

CREATE TABLE IF NOT EXISTS "raw".raw_gr_val_valuedetails
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pk_grvaluedetails PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_gr_val_valuedetails
    OWNER to proconnect;