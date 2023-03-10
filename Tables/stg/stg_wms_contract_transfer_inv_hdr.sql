CREATE TABLE stg.stg_wms_contract_transfer_inv_hdr (
    wms_cont_transfer_inv_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_cont_transfer_inv_ou integer NOT NULL,
    wms_cont_transfer_inv_date timestamp without time zone,
    wms_cont_inv_no character varying(72) COLLATE public.nocase,
    wms_cont_inv_date timestamp without time zone,
    wms_cont_flag character varying(32) COLLATE public.nocase,
    wms_cont_timestamp integer,
    wms_cont_created_by character varying(120) COLLATE public.nocase,
    wms_cont_created_dt timestamp without time zone,
    wms_cont_modified_by character varying(120) COLLATE public.nocase,
    wms_cont_modified_dt timestamp without time zone,
    wms_cont_tran_type character varying(100) COLLATE public.nocase,
    wms_cont_rcti_flag character varying(100) COLLATE public.nocase,
    wms_cont_billing_profile character varying(100) COLLATE public.nocase,
    wms_cont_transfer_received_by character varying(120) COLLATE public.nocase,
    wms_cont_transfer_date_received timestamp without time zone,
    wms_cont_transfer_inv_value numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_contract_transfer_inv_hdr
    ADD CONSTRAINT wms_contract_transfer_inv_hdr_pk PRIMARY KEY (wms_cont_transfer_inv_no, wms_cont_transfer_inv_ou);