CREATE TABLE stg.stg_wms_tariff_service_hdr (
    wms_tf_ser_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_tf_ser_ou integer NOT NULL,
    wms_tf_ser_desc character varying(1020) COLLATE public.nocase,
    wms_tf_ser_status character varying(32) COLLATE public.nocase,
    wms_tf_ser_valid_from timestamp without time zone,
    wms_tf_ser_valid_to timestamp without time zone,
    wms_tf_ser_service_period numeric,
    wms_tf_ser_uom character varying(40) COLLATE public.nocase,
    wms_tf_ser_service_level_per numeric,
    wms_tf_ser_reason_code character varying(160) COLLATE public.nocase,
    wms_tf_ser_timestamp integer,
    wms_tf_ser_created_by character varying(120) COLLATE public.nocase,
    wms_tf_ser_created_dt timestamp without time zone,
    wms_tf_ser_modified_by character varying(120) COLLATE public.nocase,
    wms_tf_ser_modified_dt timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);