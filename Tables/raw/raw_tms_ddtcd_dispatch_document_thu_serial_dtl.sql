CREATE TABLE raw.raw_tms_ddtcd_dispatch_document_thu_serial_dtl (
    raw_id bigint NOT NULL,
    ddtsd_ouinstance integer NOT NULL,
    ddtsd_dispatch_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    ddtsd_thu_line_no character varying(512) NOT NULL COLLATE public.nocase,
    ddtsd_thu_serial_line_no character varying(512) NOT NULL COLLATE public.nocase,
    ddtsd_thu_serial_no character varying(160) COLLATE public.nocase,
    ddtsd_thu_seal_no character varying(160) COLLATE public.nocase,
    ddtsd_un_code character varying(160) COLLATE public.nocase,
    ddtsd_class_code character varying(160) COLLATE public.nocase,
    ddtsd_hs_code character varying(160) COLLATE public.nocase,
    ddtsd_hazmat_code character varying(160) COLLATE public.nocase,
    ddtsd_hac_code character(4) COLLATE public.nocase,
    ddtsd_length numeric,
    ddtsd_breadth numeric,
    ddtsd_height numeric,
    ddtsd_lbh_uom character varying(60) COLLATE public.nocase,
    ddtsd_gross_weight numeric,
    ddtsd_gross_weight_uom character varying(60) COLLATE public.nocase,
    ddtsd_created_by character varying(120) COLLATE public.nocase,
    ddtsd_created_date timestamp without time zone,
    ddtsd_last_modified_by character varying(120) COLLATE public.nocase,
    ddtsd_lst_modified_date timestamp without time zone,
    ddtsd_timestamp integer,
    ddtsd_altqty numeric,
    ddtsd_altqty_uom character varying(60) COLLATE public.nocase,
    ddtsd_customs_sealno character varying(1020) COLLATE public.nocase,
    ddtsd_container_type_specs character varying(16000) COLLATE public.nocase,
    ddtsd_container_size_specs character varying(16000) COLLATE public.nocase,
    ddtsd_customer_serial_no character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_ddtcd_dispatch_document_thu_serial_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_ddtcd_dispatch_document_thu_serial_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_ddtcd_dispatch_document_thu_serial_dtl
    ADD CONSTRAINT raw_tms_ddtcd_dispatch_document_thu_serial_dtl_pkey PRIMARY KEY (raw_id);