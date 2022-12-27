CREATE TABLE dwh.f_cdiitemdtl (
    cdi_itm_dtl_key bigint NOT NULL,
    uom_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    line_no integer,
    ctimestamp integer,
    visible_line_no integer,
    item_tcd_code character varying(80) COLLATE public.nocase,
    item_tcd_var character varying(80) COLLATE public.nocase,
    usage_id character varying(40) COLLATE public.nocase,
    item_type character varying(50) COLLATE public.nocase,
    uom character varying(30) COLLATE public.nocase,
    item_qty numeric(20,2),
    unit_price numeric(20,2),
    base_value numeric(20,2),
    item_amount numeric(20,2),
    line_amount numeric(20,2),
    base_amount numeric(20,2),
    sale_purpose character varying(80) COLLATE public.nocase,
    alloc_method character varying(80) COLLATE public.nocase,
    attr_alloc character varying(10) COLLATE public.nocase,
    proposal_no character varying(40) COLLATE public.nocase,
    ship_to_cust character varying(40) COLLATE public.nocase,
    ship_to_id character varying(20) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    item_desc character varying(300) COLLATE public.nocase,
    usage_desc character varying(510) COLLATE public.nocase,
    draft_bill_line_no integer,
    nature character varying(80) COLLATE public.nocase,
    draft_bill_no character varying(40) COLLATE public.nocase,
    line_account character varying(80) COLLATE public.nocase,
    own_tax_region character varying(20) COLLATE public.nocase,
    decl_tax_region character varying(20) COLLATE public.nocase,
    party_tax_region character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_cdiitemdtl ALTER COLUMN cdi_itm_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_cdiitemdtl_cdi_itm_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_cdiitemdtl
    ADD CONSTRAINT f_cdiitemdtl_pkey PRIMARY KEY (cdi_itm_dtl_key);

ALTER TABLE ONLY dwh.f_cdiitemdtl
    ADD CONSTRAINT f_cdiitemdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no);

CREATE INDEX f_cdiitemdtl_key_idx ON dwh.f_cdiitemdtl USING btree (uom_key);