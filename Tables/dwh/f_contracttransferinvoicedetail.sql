CREATE TABLE dwh.f_contracttransferinvoicedetail (
    cont_dtl_key bigint NOT NULL,
    cont_inv_hdr_key bigint NOT NULL,
    cont_transfer_inv_no character varying(40) COLLATE public.nocase,
    cont_transfer_lineno integer,
    cont_transfer_inv_ou integer,
    cont_transfer_contract_id character varying(40) COLLATE public.nocase,
    cont_transfer_ref_doc_no character varying(40) COLLATE public.nocase,
    cont_transfer_ref_doc_date timestamp without time zone,
    cont_transfer_draft_inv_no character varying(40) COLLATE public.nocase,
    cont_supplier_id character varying(510) COLLATE public.nocase,
    cont_customer_id character varying(80) COLLATE public.nocase,
    cont_transfer_currency character varying(20) COLLATE public.nocase,
    cont_location character varying(510) COLLATE public.nocase,
    cont_fb_id character varying(40) COLLATE public.nocase,
    cont_transfer_billing_address character varying(80) COLLATE public.nocase,
    cont_refdoc_inv_value numeric(132,0),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);