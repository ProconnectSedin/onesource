CREATE TABLE stg.stg_wms_employee_location_dtl (
    wms_emp_employee_code character varying(80) NOT NULL COLLATE public.nocase,
    wms_emp_ou integer NOT NULL,
    wms_emp_lineno integer NOT NULL,
    wms_emp_geo_type character varying(32) COLLATE public.nocase,
    wms_emp_division_location character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);