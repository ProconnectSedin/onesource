-- Table: dwh.f_grfinfinancepost

-- DROP TABLE IF EXISTS dwh.f_grfinfinancepost;

CREATE TABLE IF NOT EXISTS dwh.f_grfinfinancepost
(
    gr_fin_fin_post_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    grfinfinancepost_opcoa_key bigint NOT NULL,
    gr_fin_ouinstid integer,
    gr_fin_grno character varying(36) COLLATE public.nocase,
    gr_fin_grlineno integer,
    gr_fin_finlineno integer,
    gr_fin_fbpou integer,
    gr_fin_usageid character varying(40) COLLATE public.nocase,
    gr_fin_eventcode character varying(40) COLLATE public.nocase,
    gr_fin_accounttype character varying(20) COLLATE public.nocase,
    gr_fin_drcrflag character varying(10) COLLATE public.nocase,
    gr_fin_accountcode character varying(64) COLLATE public.nocase,
    gr_fin_tranamount numeric(25,2),
    gr_fin_baseamount numeric(25,2),
    gr_fin_parbaseamount numeric(25,2),
    gr_fin_createdby character varying(60) COLLATE public.nocase,
    gr_fin_createddate timestamp without time zone,
    gr_fin_modifiedby character varying(60) COLLATE public.nocase,
    gr_fin_modifiedate timestamp without time zone,
    gr_fin_remarks character varying(510) COLLATE public.nocase,
    gr_fin_costcenter character varying(64) COLLATE public.nocase,
    gr_fin_analysis_code character varying(20) COLLATE public.nocase,
    gr_fin_sub_analysiscode character varying(20) COLLATE public.nocase,
    gr_fin_movelineno integer,
    gr_fin_fbid character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_grfinfinancepost_pkey PRIMARY KEY (gr_fin_fin_post_key),
    CONSTRAINT f_grfinfinancepost_ukey UNIQUE (gr_fin_ouinstid, gr_fin_grno, gr_fin_grlineno, gr_fin_finlineno),
    CONSTRAINT f_grfinfinancepost_grfinfinancepost_opcoa_key_fkey FOREIGN KEY (grfinfinancepost_opcoa_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_grfinfinancepost
    OWNER to proconnect;