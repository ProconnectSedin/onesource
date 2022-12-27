CREATE TABLE raw.raw_wms_equipment_geo_info_dtl (
    raw_id bigint NOT NULL,
    wms_eqp_ou integer NOT NULL,
    wms_eqp_equipment_id character varying(120) NOT NULL COLLATE public.nocase,
    wms_eqp_line_no integer NOT NULL,
    wms_eqp_geo_type character varying(32) COLLATE public.nocase,
    wms_eqp_division_location character varying(40) COLLATE public.nocase,
    wms_eqp_attached integer,
    wms_eqp_valid_from timestamp without time zone,
    wms_eqp_valid_to timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_equipment_geo_info_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_equipment_geo_info_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_equipment_geo_info_dtl
    ADD CONSTRAINT raw_wms_equipment_geo_info_dtl_pkey PRIMARY KEY (raw_id);