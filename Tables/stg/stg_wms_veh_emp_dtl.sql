CREATE TABLE stg.stg_wms_veh_emp_dtl (
    wms_veh_ou integer NOT NULL,
    wms_veh_id character varying(120) NOT NULL COLLATE public.nocase,
    wms_veh_line_no integer NOT NULL,
    wms_veh_emp_id character varying(80) COLLATE public.nocase,
    wms_veh_mapping_type character varying(32) COLLATE public.nocase,
    wms_veh_default integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);