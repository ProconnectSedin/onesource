CREATE TABLE raw.raw_wms_stage_mas_dtl (
    raw_id bigint NOT NULL,
    wms_stg_mas_ou integer NOT NULL,
    wms_stg_mas_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_stg_mas_loc character varying(40) NOT NULL COLLATE public.nocase,
    wms_stg_line_no integer NOT NULL,
    wms_stg_handl_eqp_type character varying(160) COLLATE public.nocase,
    wms_stg_vehicle_type character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);