CREATE TABLE raw.raw_cdcn_item_dtl (
    raw_id bigint NOT NULL,
    tran_type character varying(40) NOT NULL COLLATE public.nocase,
    tran_ou integer NOT NULL,
    tran_no character varying(72) NOT NULL COLLATE public.nocase,
    line_no integer NOT NULL,
    "timestamp" integer NOT NULL,
    visible_line_no integer,
    ref_doc_type character varying(40) COLLATE public.nocase,
    ref_doc_no character varying(72) COLLATE public.nocase,
    po_ou integer,
    item_tcd_code character varying(128) COLLATE public.nocase,
    item_tcd_var character varying(128) COLLATE public.nocase,
    item_qty numeric,
    unit_price numeric,
    item_amount numeric,
    remarks character varying(1020) COLLATE public.nocase,
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
    ref_doc_line integer,
    base_value numeric,
    ref_doc_date timestamp without time zone,
    ccdesc character varying(1020) COLLATE public.nocase,
    mail_sent character varying(100) DEFAULT 'N'::character varying COLLATE public.nocase,
    own_tax_region character varying(40) COLLATE public.nocase,
    decl_tax_region character varying(40) COLLATE public.nocase,
    party_tax_region character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_cdcn_item_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_cdcn_item_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_cdcn_item_dtl
    ADD CONSTRAINT raw_cdcn_item_dtl_pkey PRIMARY KEY (raw_id);