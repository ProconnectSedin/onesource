CREATE TABLE raw.raw_wms_employee_unav_dates_dtl (
    raw_id bigint NOT NULL,
    wms_emp_employee_code character varying(80) NOT NULL COLLATE public.nocase,
    wms_emp_ou integer NOT NULL,
    wms_emp_lineno integer NOT NULL,
    wms_emp_from_date timestamp without time zone,
    wms_emp_to_date timestamp without time zone,
    wms_emp_reason_code character varying(160) COLLATE public.nocase,
    wms_emp_all_shift integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);