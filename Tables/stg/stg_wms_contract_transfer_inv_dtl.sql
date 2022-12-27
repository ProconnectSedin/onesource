CREATE TABLE stg.stg_wms_contract_transfer_inv_dtl (
    wms_cont_transfer_inv_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_cont_transfer_lineno integer NOT NULL,
    wms_cont_transfer_inv_ou integer NOT NULL,
    wms_cont_transfer_contract_id character varying(72) COLLATE public.nocase,
    wms_cont_transfer_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_cont_transfer_ref_doc_date timestamp without time zone,
    wms_cont_transfer_draft_inv_no character varying(72) COLLATE public.nocase,
    wms_cont_supplier_id character varying(1020) COLLATE public.nocase,
    wms_cont_customer_id character varying(160) COLLATE public.nocase,
    wms_cont_transfer_currency character(20) COLLATE public.nocase,
    wms_cont_location character varying(1020) COLLATE public.nocase,
    wms_cont_fb_id character varying(80) COLLATE public.nocase,
    wms_cont_transfer_billing_address character varying(160) COLLATE public.nocase,
    wms_cont_refdoc_inv_value numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_contract_transfer_inv_dtl
    ADD CONSTRAINT wms_contract_transfer_inv_dtl_pk PRIMARY KEY (wms_cont_transfer_inv_no, wms_cont_transfer_lineno, wms_cont_transfer_inv_ou);