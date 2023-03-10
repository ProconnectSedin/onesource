CREATE TABLE stg.stg_wms_employee_license_dtl (
    wms_emp_employee_code character varying(80) NOT NULL COLLATE public.nocase,
    wms_emp_ou integer NOT NULL,
    wms_emp_lineno integer NOT NULL,
    wms_emp_license_type character varying(160) COLLATE public.nocase,
    wms_emp_license_num character varying(200) COLLATE public.nocase,
    wms_emp_description character varying(400) COLLATE public.nocase,
    wms_emp_issued_date timestamp without time zone,
    wms_emp_valid_from timestamp without time zone,
    wms_emp_valid_till timestamp without time zone,
    wms_emp_issuing_authority character varying(1020) COLLATE public.nocase,
    wms_emp_demerit_point character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_employee_license_dtl
    ADD CONSTRAINT wms_employee_license_dtl_pk PRIMARY KEY (wms_emp_employee_code, wms_emp_ou, wms_emp_lineno);