-- Table: dwh.f_grvalvaluedetails

-- DROP TABLE IF EXISTS dwh.f_grvalvaluedetails;

CREATE TABLE IF NOT EXISTS dwh.f_grvalvaluedetails
(
    grvalvaluedetails_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    gr_val_ouinstid integer,
    gr_val_grno character varying(36) COLLATE public.nocase,
    gr_val_grlineno integer,
    gr_val_cost numeric(13,2),
    gr_val_costper numeric(13,2),
    gr_val_stdcost numeric(13,2),
    gr_val_accunit character varying(40) COLLATE public.nocase,
    gr_val_acusage character varying(40) COLLATE public.nocase,
    gr_val_linetcdvalue numeric(13,2),
    gr_val_lineotcdvalue numeric(13,2),
    gr_val_doctcdstkvalue numeric(13,2),
    gr_val_linetcdstkvalue numeric(13,2),
    gr_val_createdby character varying(60) COLLATE public.nocase,
    gr_val_createdate timestamp without time zone,
    gr_val_modifiedby character varying(60) COLLATE public.nocase,
    gr_val_modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_grvalvaluedetails_pkey PRIMARY KEY (grvalvaluedetails_key),
    CONSTRAINT f_grvalvaluedetails_ukey UNIQUE (gr_val_ouinstid, gr_val_grno, gr_val_grlineno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_grvalvaluedetails
    OWNER to proconnect;
-- Index: f_grvalvaluedetails_key_idx1

-- DROP INDEX IF EXISTS dwh.f_grvalvaluedetails_key_idx1;

CREATE INDEX IF NOT EXISTS f_grvalvaluedetails_key_idx1
    ON dwh.f_grvalvaluedetails USING btree
    (gr_val_ouinstid ASC NULLS LAST, gr_val_grno COLLATE public.nocase ASC NULLS LAST, gr_val_grlineno ASC NULLS LAST)
    TABLESPACE pg_default;