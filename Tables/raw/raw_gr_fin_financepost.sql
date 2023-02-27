-- Table: raw.raw_gr_fin_financepost

-- DROP TABLE IF EXISTS "raw".raw_gr_fin_financepost;

CREATE TABLE IF NOT EXISTS "raw".raw_gr_fin_financepost
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT raw_gr_fin_financepost_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_gr_fin_financepost
    OWNER to proconnect;