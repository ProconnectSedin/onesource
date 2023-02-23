-- Table: dwh.f_grlindetails

-- DROP TABLE IF EXISTS dwh.f_grlindetails;

CREATE TABLE IF NOT EXISTS dwh.f_grlindetails
(
    grlindetails_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    grlindetails_itm_hdr_key bigint NOT NULL,
    grlindetails_uom_key bigint NOT NULL,
    grlindetails_loc_key bigint NOT NULL,
    gr_lin_ouinstid integer,
    gr_lin_grno character varying(36) COLLATE public.nocase,
    gr_lin_grlineno integer,
    gr_lin_orderlineno integer,
    gr_lin_orderschno integer,
    gr_lin_byprodsno integer,
    gr_lin_linestatus character varying(10) COLLATE public.nocase,
    gr_lin_itemcode character varying(64) COLLATE public.nocase,
    gr_lin_itemvariant character varying(16) COLLATE public.nocase,
    gr_lin_itemdesc character varying(1500) COLLATE public.nocase,
    gr_lin_itemdesc_shd character varying(1500) COLLATE public.nocase,
    gr_lin_adhocitemcls character varying(20) COLLATE public.nocase,
    gr_lin_orderqty numeric(13,2),
    gr_lin_orderschqty numeric(13,2),
    gr_lin_proposalid character varying(36) COLLATE public.nocase,
    gr_lin_schdate timestamp without time zone,
    gr_lin_receivedqty numeric(13,2),
    gr_lin_quarnqty numeric(13,2),
    gr_lin_acceptedqty numeric(13,2),
    gr_lin_movedqty numeric(13,2),
    gr_lin_delynoteqty numeric(13,2),
    gr_lin_uom character varying(20) COLLATE public.nocase,
    gr_lin_instype character varying(16) COLLATE public.nocase,
    gr_lin_matchtype character varying(16) COLLATE public.nocase,
    gr_lin_toltype character varying(16) COLLATE public.nocase,
    gr_lin_tolplus integer,
    gr_lin_tolminus integer,
    gr_lin_frdate timestamp without time zone,
    gr_lin_fadate timestamp without time zone,
    gr_lin_fmdate timestamp without time zone,
    gr_lin_consrule character varying(16) COLLATE public.nocase,
    gr_lin_bomrefer character varying(40) COLLATE public.nocase,
    gr_lin_outputtype character varying(16) COLLATE public.nocase,
    gr_lin_ordrefdoctype character varying(80) COLLATE public.nocase,
    gr_lin_qlyattrib character varying(16) COLLATE public.nocase,
    gr_lin_createdby character varying(60) COLLATE public.nocase,
    gr_lin_createdate timestamp without time zone,
    gr_lin_modifiedby character varying(60) COLLATE public.nocase,
    gr_lin_modifieddate timestamp without time zone,
    gr_lin_po_cost numeric(13,2),
    gr_lin_costper numeric(13,2),
    gr_lin_fr_remarks character varying(2000) COLLATE public.nocase,
    gr_lin_fa_remarks character varying(2000) COLLATE public.nocase,
    gr_lin_fm_remarks character varying(2000) COLLATE public.nocase,
    gr_lin_location character varying(32) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_grlindetails_pkey PRIMARY KEY (grlindetails_key),
    CONSTRAINT f_grlindetails_ukey UNIQUE (gr_lin_ouinstid, gr_lin_grno, gr_lin_grlineno),
    CONSTRAINT f_grlindetails_grlindetails_itm_hdr_key_fkey FOREIGN KEY (grlindetails_itm_hdr_key)
        REFERENCES dwh.d_itemheader (itm_hdr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_grlindetails_grlindetails_loc_key_fkey FOREIGN KEY (grlindetails_loc_key)
        REFERENCES dwh.d_location (loc_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_grlindetails_grlindetails_uom_key_fkey FOREIGN KEY (grlindetails_uom_key)
        REFERENCES dwh.d_uom (uom_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_grlindetails
    OWNER to proconnect;
-- Index: f_grlindetails_key_idx1

-- DROP INDEX IF EXISTS dwh.f_grlindetails_key_idx1;

CREATE INDEX IF NOT EXISTS f_grlindetails_key_idx1
    ON dwh.f_grlindetails USING btree
    (gr_lin_ouinstid ASC NULLS LAST, gr_lin_grno COLLATE public.nocase ASC NULLS LAST, gr_lin_grlineno ASC NULLS LAST)
    TABLESPACE pg_default;