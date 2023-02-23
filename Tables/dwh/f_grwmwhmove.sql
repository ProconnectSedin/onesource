-- Table: dwh.f_grwmwhmove

-- DROP TABLE IF EXISTS dwh.f_grwmwhmove;

CREATE TABLE IF NOT EXISTS dwh.f_grwmwhmove
(
    gr_wm_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    gr_wm_whkey bigint,
    gr_wm_uomkey bigint,
    gr_wm_ouinstid integer,
    gr_wm_grno character varying(36) COLLATE public.nocase,
    gr_wm_grlineno integer,
    gr_wm_moveno integer,
    gr_wm_status character varying(10) COLLATE public.nocase,
    gr_wm_movedqty numeric(13,2),
    gr_wm_whcode character varying(20) COLLATE public.nocase,
    gr_wm_createdby character varying(60) COLLATE public.nocase,
    gr_wm_createdate timestamp without time zone,
    gr_wm_modifiedby character varying(60) COLLATE public.nocase,
    gr_wm_modifieddate timestamp without time zone,
    gr_wm_stkuom character varying(20) COLLATE public.nocase,
    gr_wm_convfact numeric(13,2),
    gr_wm_ordsubsch_no integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT gr_wm_pkey PRIMARY KEY (gr_wm_key),
    CONSTRAINT gr_wm_ukey UNIQUE (gr_wm_ouinstid, gr_wm_grno, gr_wm_grlineno, gr_wm_moveno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_grwmwhmove
    OWNER to proconnect;
-- Index: f_grwmwhmove_key_idx

-- DROP INDEX IF EXISTS dwh.f_grwmwhmove_key_idx;

CREATE INDEX IF NOT EXISTS f_grwmwhmove_key_idx
    ON dwh.f_grwmwhmove USING btree
    (gr_wm_ouinstid ASC NULLS LAST, gr_wm_grno COLLATE public.nocase ASC NULLS LAST, gr_wm_grlineno ASC NULLS LAST, gr_wm_moveno ASC NULLS LAST)
    TABLESPACE pg_default;