-- Table: stg.stg_gr_wm_whmove

-- DROP TABLE IF EXISTS stg.stg_gr_wm_whmove;

CREATE TABLE IF NOT EXISTS stg.stg_gr_wm_whmove
(
    gr_wm_ouinstid integer NOT NULL,
    gr_wm_grno character varying(72) COLLATE public.nocase NOT NULL,
    gr_wm_grlineno integer NOT NULL,
    gr_wm_moveno integer NOT NULL,
    gr_wm_status character(8) COLLATE public.nocase,
    gr_wm_movedqty numeric NOT NULL,
    gr_wm_whcode character varying(40) COLLATE public.nocase NOT NULL,
    gr_wm_zone character varying(40) COLLATE public.nocase,
    gr_wm_bin character varying(40) COLLATE public.nocase,
    gr_wm_createdby character varying(120) COLLATE public.nocase NOT NULL,
    gr_wm_createdate timestamp without time zone NOT NULL,
    gr_wm_modifiedby character varying(120) COLLATE public.nocase NOT NULL,
    gr_wm_modifieddate timestamp without time zone NOT NULL,
    gr_wm_altuom character varying(40) COLLATE public.nocase,
    gr_wm_altqty numeric,
    gr_wm_remarks character varying(4000) COLLATE public.nocase,
    gr_wm_stkuom character varying(40) COLLATE public.nocase,
    gr_wm_convfact numeric,
    gr_wm_ordsubsch_no integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pk_grwhmove PRIMARY KEY (gr_wm_grno, gr_wm_ouinstid, gr_wm_grlineno, gr_wm_moveno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_gr_wm_whmove
    OWNER to proconnect;
-- Index: stg_gr_wm_whmove_key_idx

-- DROP INDEX IF EXISTS stg.stg_gr_wm_whmove_key_idx;

CREATE INDEX IF NOT EXISTS stg_gr_wm_whmove_key_idx
    ON stg.stg_gr_wm_whmove USING btree
    (gr_wm_ouinstid ASC NULLS LAST, gr_wm_grno COLLATE public.nocase ASC NULLS LAST, gr_wm_grlineno ASC NULLS LAST, gr_wm_moveno ASC NULLS LAST)
    TABLESPACE pg_default;