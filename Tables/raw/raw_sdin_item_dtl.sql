-- Table: raw.raw_sdin_item_dtl

-- DROP TABLE IF EXISTS "raw".raw_sdin_item_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_sdin_item_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    line_no integer NOT NULL,
    "timestamp" integer NOT NULL,
    visible_line_no integer,
    gr_ou integer,
    gr_no character varying(72) COLLATE public.nocase,
    item_tcd_code character varying(128) COLLATE public.nocase,
    item_tcd_var character varying(128) COLLATE public.nocase,
    uom character varying(60) COLLATE public.nocase,
    item_qty numeric,
    item_rate numeric,
    rate_per numeric,
    item_amount numeric,
    tax_amount numeric,
    disc_amount numeric,
    line_amount numeric,
    base_amount numeric,
    par_base_amount numeric,
    usage character varying(160) COLLATE public.nocase,
    proposal_no character varying(72) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    rcpt_qty numeric,
    base_value numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    accountusageid character varying(80) COLLATE public.nocase,
    retentionml numeric,
    holdml numeric,
    trnsfr_bill_lineno integer,
    own_tax_region character varying(40) COLLATE public.nocase,
    party_tax_region character varying(40) COLLATE public.nocase,
    decl_tax_region character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_sdin_item_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_sdin_item_dtl
    OWNER to proconnect;