CREATE TABLE raw.raw_tms_ddtd_dispatch_document_thu_dtl (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_tms_ddtd_dispatch_document_thu_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_ddtd_dispatch_document_thu_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_ddtd_dispatch_document_thu_dtl
    ADD CONSTRAINT raw_tms_ddtd_dispatch_document_thu_dtl_pkey PRIMARY KEY (raw_id);