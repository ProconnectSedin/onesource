CREATE TABLE raw.raw_tms_ddtsd_dispatch_document_thu_sku_dtl (
    raw_id bigint NOT NULL,
    ddtsd_ou integer NOT NULL,
    ddtsd_dispatch_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    ddtsd_thu_line_no character varying(512) NOT NULL COLLATE public.nocase,
    ddtsd_serial_no character varying(160) COLLATE public.nocase,
    ddtsd_child_thu_id character varying(160) COLLATE public.nocase,
    ddtsd_child_serial_no character varying(160) COLLATE public.nocase,
    ddtsd_sku_line_no character varying(512) NOT NULL COLLATE public.nocase,
    ddtsd_sku_id character varying(160) COLLATE public.nocase,
    ddtsd_sku_rate numeric,
    ddtsd_sku_quantity numeric,
    ddtsd_sku_value numeric,
    ddtsd_sku_batch_id character varying(160) COLLATE public.nocase,
    ddtsd_sku_mfg_date timestamp without time zone,
    ddtsd_sku_expiry_date timestamp without time zone,
    ddtsd_created_by character varying(120) COLLATE public.nocase,
    ddtsd_created_date timestamp without time zone,
    ddtsd_modified_by character varying(120) COLLATE public.nocase,
    ddtsd_modified_date timestamp without time zone,
    ddtsd_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_ddtsd_dispatch_document_thu_sku_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_ddtsd_dispatch_document_thu_sku_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_ddtsd_dispatch_document_thu_sku_dtl
    ADD CONSTRAINT raw_tms_ddtsd_dispatch_document_thu_sku_dtl_pkey PRIMARY KEY (raw_id);