CREATE TABLE raw.raw_wms_employee_location_dtl (
    raw_id bigint NOT NULL,
    wms_emp_employee_code character varying(80) NOT NULL COLLATE public.nocase,
    wms_emp_ou integer NOT NULL,
    wms_emp_lineno integer NOT NULL,
    wms_emp_geo_type character varying(32) COLLATE public.nocase,
    wms_emp_division_location character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_employee_location_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_employee_location_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_employee_location_dtl
    ADD CONSTRAINT raw_wms_employee_location_dtl_pkey PRIMARY KEY (raw_id);