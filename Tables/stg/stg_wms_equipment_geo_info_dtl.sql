CREATE TABLE stg.stg_wms_equipment_geo_info_dtl (
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