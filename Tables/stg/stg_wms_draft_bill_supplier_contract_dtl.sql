CREATE TABLE stg.stg_wms_draft_bill_supplier_contract_dtl (
    wms_draft_bill_ou integer NOT NULL,
    wms_draft_bill_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_draft_bill_division character varying(40) NOT NULL COLLATE public.nocase,
    wms_draft_bill_tran_type character varying(100) NOT NULL COLLATE public.nocase,
    wms_draft_bill_ref_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_draft_bill_ref_doc_type character varying(32) NOT NULL COLLATE public.nocase,
    wms_draft_bill_contract_id character varying(72) COLLATE public.nocase,
    wms_draft_bill_contract_amend_no integer,
    wms_draft_bill_vendor_id character varying(64) NOT NULL COLLATE public.nocase,
    wms_draft_bill_created_by character varying(120) COLLATE public.nocase,
    wms_draft_bill_created_date timestamp without time zone,
    wms_draft_bill_billing_status character varying(32) COLLATE public.nocase,
    wms_draft_bill_value numeric,
    wms_draft_bill_booking_location character varying(40) COLLATE public.nocase,
    wms_draft_bill_modified_by character varying(120) COLLATE public.nocase,
    wms_draft_bill_modified_date timestamp without time zone,
    wms_draft_bill_last_depart_date timestamp without time zone,
    wms_draft_bill_resource_type character varying(1020) NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_draft_bill_supplier_contract_dtl
    ADD CONSTRAINT wms_draft_bill_supplier_contract_dtl_pk PRIMARY KEY (wms_draft_bill_ou, wms_draft_bill_location, wms_draft_bill_division, wms_draft_bill_tran_type, wms_draft_bill_ref_doc_no, wms_draft_bill_ref_doc_type, wms_draft_bill_vendor_id, wms_draft_bill_resource_type);