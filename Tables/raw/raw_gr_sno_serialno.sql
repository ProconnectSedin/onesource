-- Table: raw.raw_gr_sno_serialno

-- DROP TABLE IF EXISTS "raw".raw_gr_sno_serialno;

CREATE TABLE IF NOT EXISTS "raw".raw_gr_sno_serialno
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pk_grserialno PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_gr_sno_serialno
    OWNER to proconnect;