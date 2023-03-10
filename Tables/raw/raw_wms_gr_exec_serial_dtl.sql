CREATE TABLE raw.raw_wms_gr_exec_serial_dtl (
    raw_id bigint NOT NULL,
    wms_gr_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gr_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_gr_exec_ou integer NOT NULL,
    wms_gr_lineno integer NOT NULL,
    wms_gr_po_no character varying(72) COLLATE public.nocase,
    wms_gr_po_sno character varying(112) COLLATE public.nocase,
    wms_gr_item character varying(128) COLLATE public.nocase,
    wms_gr_serial_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_gr_status character varying(32) COLLATE public.nocase,
    wms_gr_cust_sno character varying(112) COLLATE public.nocase,
    wms_gr_3pl_sno character varying(112) COLLATE public.nocase,
    wms_gr_lot_no character varying(112) COLLATE public.nocase,
    wms_gr_item_lineno integer,
    wms_gr_warranty_sno character varying(112) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_gr_exec_serial_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_gr_exec_serial_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_gr_exec_serial_dtl
    ADD CONSTRAINT raw_wms_gr_exec_serial_dtl_pkey PRIMARY KEY (raw_id);