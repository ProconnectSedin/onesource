CREATE TABLE raw.raw_wms_contract_transfer_inv_dtl (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_wms_contract_transfer_inv_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_contract_transfer_inv_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_contract_transfer_inv_dtl
    ADD CONSTRAINT raw_wms_contract_transfer_inv_dtl_pkey PRIMARY KEY (raw_id);