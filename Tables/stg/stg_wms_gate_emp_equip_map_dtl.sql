CREATE TABLE stg.stg_wms_gate_emp_equip_map_dtl (
    wms_gate_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gate_ou integer NOT NULL,
    wms_gate_lineno integer NOT NULL,
    wms_gate_shift_code character varying(160) COLLATE public.nocase,
    wms_gate_emp_code character varying(80) COLLATE public.nocase,
    wms_gate_euip_code character varying(120) COLLATE public.nocase,
    wms_gate_area character varying(72) COLLATE public.nocase,
    wms_gate_timestamp integer,
    wms_gate_created_by character varying(120) COLLATE public.nocase,
    wms_gate_created_date timestamp without time zone,
    wms_gate_modified_by character varying(120) COLLATE public.nocase,
    wms_gate_modified_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);