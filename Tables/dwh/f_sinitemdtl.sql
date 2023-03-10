CREATE TABLE dwh.f_sinitemdtl (
    si_sinitm_key bigint NOT NULL,
    si_sinitm_inv_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    line_no integer,
    "timestamp" integer,
    po_amendment_no integer,
    visible_line_no integer,
    ref_doc_type character varying(20) COLLATE public.nocase,
    ref_doc_no character varying(40) COLLATE public.nocase,
    ref_doc_date timestamp without time zone,
    pors_type character varying(20) COLLATE public.nocase,
    po_no character varying(40) COLLATE public.nocase,
    po_ou integer,
    item_tcd_code character varying(80) COLLATE public.nocase,
    item_tcd_var character varying(80) COLLATE public.nocase,
    uom character varying(30) COLLATE public.nocase,
    rate_per numeric(13,2),
    invoice_qty numeric(13,2),
    invoice_rate numeric(13,2),
    proposed_qty numeric(13,2),
    proposed_rate numeric(13,2),
    proposed_amount numeric(13,2),
    remarks character varying(2000) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    ref_doc_ou integer,
    tax_amount numeric(13,2),
    disc_amount numeric(13,2),
    line_amount numeric(13,2),
    item_amount numeric(13,2),
    base_amount numeric(13,2),
    original_proposed_amt numeric(13,2),
    original_proposed_qty numeric(13,2),
    po_line_no integer,
    ref_doc_line_no integer,
    base_value numeric(13,2),
    matching_type character varying(10) COLLATE public.nocase,
    orderno_instname character varying(80) COLLATE public.nocase,
    refdocno_instname character varying(80) COLLATE public.nocase,
    orderno_cur character varying(10) COLLATE public.nocase,
    po_date timestamp without time zone,
    po_categ character varying(30) COLLATE public.nocase,
    gr_opt character varying(30) COLLATE public.nocase,
    po_qty numeric(13,2),
    imports_flag character varying(30) COLLATE public.nocase,
    retention_amt numeric(13,2),
    ipv_flag character varying(10) COLLATE public.nocase,
    epv_flag character varying(10) COLLATE public.nocase,
    retentionml numeric(13,2),
    holdml numeric(13,2),
    acusage character varying(40) COLLATE public.nocase,
    own_tax_region character varying(20) COLLATE public.nocase,
    party_tax_region character varying(20) COLLATE public.nocase,
    decl_tax_region character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_sinitemdtl ALTER COLUMN si_sinitm_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_sinitemdtl_si_sinitm_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_sinitemdtl
    ADD CONSTRAINT f_sinitemdtl_pkey PRIMARY KEY (si_sinitm_key);

ALTER TABLE ONLY dwh.f_sinitemdtl
    ADD CONSTRAINT f_sinitemdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no, ipv_flag, epv_flag);

ALTER TABLE ONLY dwh.f_sinitemdtl
    ADD CONSTRAINT f_sinitemdtl_si_sinitm_inv_key_fkey FOREIGN KEY (si_sinitm_inv_key) REFERENCES dwh.f_sininvoicehdr(si_inv_key);

CREATE INDEX f_sinitemdtl_key_idx ON dwh.f_sinitemdtl USING btree (tran_type, tran_ou, tran_no, line_no, ipv_flag, epv_flag);

CREATE INDEX f_sinitemdtl_key_idx1 ON dwh.f_sinitemdtl USING btree (si_sinitm_inv_key);