CREATE TABLE raw.raw_wms_tariff_service_hdr (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_wms_tariff_service_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_tariff_service_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_tariff_service_hdr
    ADD CONSTRAINT raw_wms_tariff_service_hdr_pkey PRIMARY KEY (raw_id);