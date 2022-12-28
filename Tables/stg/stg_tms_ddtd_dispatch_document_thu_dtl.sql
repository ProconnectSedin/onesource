CREATE TABLE stg.stg_tms_ddtd_dispatch_document_thu_dtl (
    ddtd_ouinstance integer NOT NULL,
    ddtd_dispatch_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    ddtd_thu_line_no character varying(512) NOT NULL COLLATE public.nocase,
    ddtd_thu_id character varying(160) COLLATE public.nocase,
    ddtd_thu_qty numeric,
    ddtd_class_stores character varying(160) COLLATE public.nocase,
    ddtd_thu_desc character varying(160) COLLATE public.nocase,
    ddtd_thu_vol numeric,
    ddtd_thu_vol_uom character varying(60) COLLATE public.nocase,
    ddtd_thu_weight numeric,
    ddtd_thu_weight_uom character varying(60) COLLATE public.nocase,
    ddtd_created_by character varying(120) COLLATE public.nocase,
    ddtd_created_date timestamp without time zone,
    ddtd_last_modified_by character varying(120) COLLATE public.nocase,
    ddtd_lst_modified_date timestamp without time zone,
    ddtd_timestamp integer,
    ddtd_transfer_type character varying(160) COLLATE public.nocase,
    ddtd_remarks character varying(160) COLLATE public.nocase,
    ddtd_vendor_thu_id character varying(160) COLLATE public.nocase,
    ddtd_transfer_doc_no character varying(160) COLLATE public.nocase,
    ddtd_vendor_ac_no character varying(160) COLLATE public.nocase,
    ddtd_damaged_qty numeric,
    ddtd_billing_status character varying(32) COLLATE public.nocase,
    ddtd_no_of_pallet_space numeric,
    ddtd_height numeric,
    ddtd_commodityid character varying(72) COLLATE public.nocase,
    ddtd_commodity_qty numeric,
    ddtd_qty_uom character varying(160) COLLATE public.nocase,
    ddtd_thu_qty_uom character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_ddtd_dispatch_document_thu_dtl
    ADD CONSTRAINT pk_tms_ddtd_dispatch_document_thu_dtl PRIMARY KEY (ddtd_ouinstance, ddtd_dispatch_doc_no, ddtd_thu_line_no);

CREATE INDEX stg_tms_ddtd_dispatch_document_thu_dtl_key_idx1 ON stg.stg_tms_ddtd_dispatch_document_thu_dtl USING btree (ddtd_ouinstance, ddtd_dispatch_doc_no, ddtd_thu_line_no);