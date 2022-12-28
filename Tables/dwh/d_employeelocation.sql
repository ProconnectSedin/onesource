CREATE TABLE dwh.d_employeelocation (
    emp_loc_key bigint NOT NULL,
    emp_employee_code character varying(40) COLLATE public.nocase,
    emp_ou integer,
    emp_lineno integer,
    emp_geo_type character varying(20) COLLATE public.nocase,
    emp_division_location character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_employeelocation ALTER COLUMN emp_loc_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_employeelocation_emp_loc_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_employeelocation
    ADD CONSTRAINT d_employeelocation_pkey PRIMARY KEY (emp_loc_key);

ALTER TABLE ONLY dwh.d_employeelocation
    ADD CONSTRAINT d_employeelocation_ukey UNIQUE (emp_employee_code, emp_ou, emp_lineno);