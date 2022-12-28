CREATE TABLE stg.stg_wms_employee_unav_dates_dtl (
    wms_emp_employee_code character varying(80) NOT NULL COLLATE public.nocase,
    wms_emp_ou integer NOT NULL,
    wms_emp_lineno integer NOT NULL,
    wms_emp_from_date timestamp without time zone,
    wms_emp_to_date timestamp without time zone,
    wms_emp_reason_code character varying(160) COLLATE public.nocase,
    wms_emp_all_shift integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_employee_unav_dates_dtl
    ADD CONSTRAINT wms_employee_unav_dates_dtl_pk PRIMARY KEY (wms_emp_employee_code, wms_emp_ou, wms_emp_lineno);