CREATE TABLE stg.stg_wms_thu_item_mapping_dtl (
    wms_thu_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_thu_ou integer NOT NULL,
    wms_thu_serial_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_thu_id character varying(160) NOT NULL COLLATE public.nocase,
    wms_thu_item character varying(128) NOT NULL COLLATE public.nocase,
    wms_thu_lot_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_thu_itm_serial_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_thu_qty numeric,
    wms_thu_created_by character varying(120) COLLATE public.nocase,
    wms_thu_created_date timestamp without time zone,
    wms_thu_modified_by character varying(120) COLLATE public.nocase,
    wms_thu_modified_date timestamp without time zone,
    wms_thu_ser_no character varying(112) COLLATE public.nocase,
    wms_thu_serial_no2 character varying(112) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);