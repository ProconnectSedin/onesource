-- Table: stg.stg_sin_po_gr_map

-- DROP TABLE IF EXISTS stg.stg_sin_po_gr_map;

CREATE TABLE IF NOT EXISTS stg.stg_sin_po_gr_map
(
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    line_no integer NOT NULL,
    ref_doc_ou integer,
    ref_doc_no character varying(72) COLLATE public.nocase,
    ref_doc_line_no integer,
    "timestamp" integer,
    pors_type character varying(40) COLLATE public.nocase,
    po_ou integer,
    po_no character varying(72) COLLATE public.nocase,
    po_line_no integer,
    po_amendment_no integer,
    item_type character varying(12) COLLATE public.nocase,
    item_tcd_code character varying(128) COLLATE public.nocase,
    item_tcd_var character varying(128) COLLATE public.nocase,
    recd_qty numeric,
    recd_amount numeric,
    acc_qty numeric,
    acc_amount numeric,
    billed_qty numeric,
    billed_amount numeric,
    matching_type character varying(128) COLLATE public.nocase,
    tolerance_type character varying(100) COLLATE public.nocase,
    tolreance_perc integer,
    proposed_qty numeric,
    proposed_rate numeric,
    proposed_amount numeric,
    matched_qty numeric,
    matched_amount numeric,
    match_status character varying(12) COLLATE public.nocase,
    positivematch_status character varying(12) COLLATE public.nocase,
    negativematch_status character varying(12) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_sin_po_gr_map
    OWNER to proconnect;
-- Index: stg_sin_po_gr_map_key_idx

-- DROP INDEX IF EXISTS stg.stg_sin_po_gr_map_key_idx;

CREATE INDEX IF NOT EXISTS stg_sin_po_gr_map_key_idx
    ON stg.stg_sin_po_gr_map USING btree
    (tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;