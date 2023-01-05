-- Table: dwh.f_cdcnitemdtl

-- DROP TABLE IF EXISTS dwh.f_cdcnitemdtl;

CREATE TABLE IF NOT EXISTS dwh.f_cdcnitemdtl
(
    cdcn_itm_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    line_no integer,
    "timestamp" integer,
    visible_line_no integer,
    ref_doc_type character varying(20) COLLATE public.nocase,
    ref_doc_no character varying(40) COLLATE public.nocase,
    po_ou integer,
    item_tcd_code character varying(80) COLLATE public.nocase,
    item_tcd_var character varying(80) COLLATE public.nocase,
    item_qty numeric(25,2),
    unit_price numeric(25,2),
    item_amount numeric(25,2),
    remarks character varying(510) COLLATE public.nocase,
    tax_amount numeric(25,2),
    disc_amount numeric(25,2),
    line_amount numeric(25,2),
    base_amount numeric(25,2),
    par_base_amount numeric(25,2),
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    ref_doc_line integer,
    base_value numeric(25,2),
    ref_doc_date timestamp without time zone,
    ccdesc character varying(510) COLLATE public.nocase,
    mail_sent character varying(50) COLLATE public.nocase,
    own_tax_region character varying(20) COLLATE public.nocase,
    decl_tax_region character varying(20) COLLATE public.nocase,
    party_tax_region character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_cdcnitemdtl_pkey PRIMARY KEY (cdcn_itm_dtl_key),
    CONSTRAINT f_cdcnitemdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no, "timestamp")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cdcnitemdtl
    OWNER to proconnect;