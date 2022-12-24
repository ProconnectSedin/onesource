CREATE TABLE raw.raw_wms_employee_type_dtl (
    raw_id bigint NOT NULL,
    wms_emp_employee_code character varying(80) NOT NULL COLLATE public.nocase,
    wms_emp_ou integer NOT NULL,
    wms_emp_lineno integer NOT NULL,
    wms_emp_type character varying(160) COLLATE public.nocase,
    wms_emp_priority character varying(160) COLLATE public.nocase,
    wms_emp_mapped character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);