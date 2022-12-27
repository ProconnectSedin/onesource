CREATE TABLE stg.stg_wms_employee_skills_dtl (
    wms_emp_employee_code character varying(80) NOT NULL COLLATE public.nocase,
    wms_emp_ou integer NOT NULL,
    wms_emp_lineno integer NOT NULL,
    wms_emp_skill_code character varying(160) COLLATE public.nocase,
    wms_emp_primary_skill integer,
    wms_emp_certificate_no character varying(1020) COLLATE public.nocase,
    wms_emp_certificate_type character varying(1020) COLLATE public.nocase,
    wms_emp_issued_date timestamp without time zone,
    wms_emp_valid_from timestamp without time zone,
    wms_emp_valid_till timestamp without time zone,
    wms_emp_remarks character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_employee_skills_dtl
    ADD CONSTRAINT wms_employee_skills_dtl_pk PRIMARY KEY (wms_emp_employee_code, wms_emp_ou, wms_emp_lineno);