CREATE TABLE raw.raw_wms_employee_skills_dtl (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_wms_employee_skills_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_employee_skills_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_employee_skills_dtl
    ADD CONSTRAINT raw_wms_employee_skills_dtl_pkey PRIMARY KEY (raw_id);