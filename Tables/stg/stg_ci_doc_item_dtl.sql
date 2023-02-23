-- Table: stg.stg_ci_doc_item_dtl

-- DROP TABLE IF EXISTS stg.stg_ci_doc_item_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_ci_doc_item_dtl
(
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    line_no integer NOT NULL,
    "timestamp" integer NOT NULL,
    batch_id character varying(512) COLLATE public.nocase,
    component_id character varying(64) COLLATE public.nocase,
    company_code character varying(40) COLLATE public.nocase,
    lo_id character varying(80) COLLATE public.nocase,
    item_tcd_code character varying(128) COLLATE public.nocase,
    item_tcd_var character varying(128) COLLATE public.nocase,
    visible_line_no integer,
    so_no character varying(72) COLLATE public.nocase,
    so_ou integer,
    ref_doc_no character varying(72) COLLATE public.nocase,
    ref_doc_date timestamp without time zone,
    ref_doc_ou integer,
    ship_to_cust character varying(72) COLLATE public.nocase,
    ship_to_id character varying(24) COLLATE public.nocase,
    uom character varying(60) COLLATE public.nocase,
    item_qty numeric,
    unit_price numeric,
    item_amount numeric,
    remarks character varying(1020) COLLATE public.nocase,
    item_type character varying(100) COLLATE public.nocase,
    tax_amount numeric,
    disc_amount numeric,
    line_amount numeric,
    base_amount numeric,
    par_base_amount numeric,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    item_tcd_desc character varying(600) COLLATE public.nocase,
    sale_purpose character varying(64) COLLATE public.nocase,
    warehouse_code character varying(40) COLLATE public.nocase,
    alloc_method character varying(160) COLLATE public.nocase,
    attr_alloc character varying(4) COLLATE public.nocase,
    proposal_no character varying(72) COLLATE public.nocase,
    shipping_ou integer,
    ship_to_cust_name character varying(160) COLLATE public.nocase,
    packslip_no character varying(72) COLLATE public.nocase,
    ref_doc_type character varying(40) COLLATE public.nocase,
    po_ou integer,
    base_value numeric,
    charges_amount numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ci_doc_item_dtl_pkey PRIMARY KEY (tran_type, tran_ou, tran_no, line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ci_doc_item_dtl
    OWNER to proconnect;
-- Index: stg_ci_doc_item_dtl_idx

-- DROP INDEX IF EXISTS stg.stg_ci_doc_item_dtl_idx;

CREATE INDEX IF NOT EXISTS stg_ci_doc_item_dtl_idx
    ON stg.stg_ci_doc_item_dtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;