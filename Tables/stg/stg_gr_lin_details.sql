-- Table: stg.stg_gr_lin_details

-- DROP TABLE IF EXISTS stg.stg_gr_lin_details;

CREATE TABLE IF NOT EXISTS stg.stg_gr_lin_details
(
    gr_lin_ouinstid integer NOT NULL,
    gr_lin_grno character varying(72) COLLATE public.nocase NOT NULL,
    gr_lin_grlineno integer NOT NULL,
    gr_lin_orderlineno integer NOT NULL,
    gr_lin_orderschno integer,
    gr_lin_byprodsno integer,
    gr_lin_linestatus character(8) COLLATE public.nocase NOT NULL,
    gr_lin_itemcode character varying(128) COLLATE public.nocase,
    gr_lin_itemvariant character varying(32) COLLATE public.nocase,
    gr_lin_itemdesc character varying(3000) COLLATE public.nocase,
    gr_lin_itemdesc_shd character varying(3000) COLLATE public.nocase,
    gr_lin_adhocitemcls character varying(40) COLLATE public.nocase,
    gr_lin_dwgrevno character varying(40) COLLATE public.nocase,
    gr_lin_orderqty numeric,
    gr_lin_orderschqty numeric NOT NULL,
    gr_lin_proposalid character varying(72) COLLATE public.nocase,
    gr_lin_schdate timestamp without time zone,
    gr_lin_receivedqty numeric NOT NULL,
    gr_lin_receivebay character varying(64) COLLATE public.nocase,
    gr_lin_quarnqty numeric,
    gr_lin_quarnbay character varying(40) COLLATE public.nocase,
    gr_lin_acceptedqty numeric,
    gr_lin_rejectedqty numeric,
    gr_lin_movedqty numeric,
    gr_lin_delynoteqty numeric,
    gr_lin_retnoteqty numeric,
    gr_lin_returnqty numeric,
    gr_lin_debitnoteqty numeric,
    gr_lin_resupplyqty numeric,
    gr_lin_postgrrejqty numeric,
    gr_lin_uom character varying(40) COLLATE public.nocase NOT NULL,
    gr_lin_instype character varying(32) COLLATE public.nocase NOT NULL,
    gr_lin_matchtype character varying(32) COLLATE public.nocase,
    gr_lin_toltype character varying(32) COLLATE public.nocase,
    gr_lin_tolplus integer,
    gr_lin_tolminus integer,
    gr_lin_frdate timestamp without time zone,
    gr_lin_fadate timestamp without time zone,
    gr_lin_fmdate timestamp without time zone,
    gr_lin_consrule character varying(32) COLLATE public.nocase,
    gr_lin_bomrefer character varying(80) COLLATE public.nocase,
    gr_lin_outputtype character varying(32) COLLATE public.nocase,
    gr_lin_ordrefdoctype character varying(160) COLLATE public.nocase,
    gr_lin_ordrefdocno character varying(72) COLLATE public.nocase,
    gr_lin_ordrefdoclineno integer,
    gr_lin_qlyattrib character varying(32) COLLATE public.nocase,
    gr_lin_qltyremarks character varying(4000) COLLATE public.nocase,
    gr_lin_createdby character varying(120) COLLATE public.nocase NOT NULL,
    gr_lin_createdate timestamp without time zone NOT NULL,
    gr_lin_modifiedby character varying(120) COLLATE public.nocase,
    gr_lin_modifieddate timestamp without time zone,
    gr_lin_po_cost numeric,
    gr_lin_costper numeric,
    gr_lin_fr_remarks character varying(4000) COLLATE public.nocase,
    gr_lin_fa_remarks character varying(4000) COLLATE public.nocase,
    gr_lin_fm_remarks character varying(4000) COLLATE public.nocase,
    gr_lin_projectcode character varying(280) COLLATE public.nocase,
    gr_lin_projectou integer,
    gr_lin_reftrkno integer,
    gr_lin_location character varying(64) COLLATE public.nocase,
    pending_cap_amount numeric,
    cap_amt numeric,
    writeoff_amt numeric,
    writeoff_remarks character varying(400) COLLATE public.nocase,
    writeoff_jvno character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_gr_lin_details
    OWNER to proconnect;
-- Index: stg_gr_lin_details_key_idx2

-- DROP INDEX IF EXISTS stg.stg_gr_lin_details_key_idx2;

CREATE INDEX IF NOT EXISTS stg_gr_lin_details_key_idx2
    ON stg.stg_gr_lin_details USING btree
    (gr_lin_ouinstid ASC NULLS LAST, gr_lin_grno COLLATE public.nocase ASC NULLS LAST, gr_lin_grlineno ASC NULLS LAST)
    TABLESPACE pg_default;