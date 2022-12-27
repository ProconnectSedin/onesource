CREATE TABLE dwh.d_employeelicense (
    emp_key bigint NOT NULL,
    emp_employee_code character varying(40) COLLATE public.nocase,
    emp_ou integer,
    emp_lineno integer,
    emp_license_type character varying(80) COLLATE public.nocase,
    emp_license_num character varying(100) COLLATE public.nocase,
    emp_description character varying(200) COLLATE public.nocase,
    emp_issued_date timestamp without time zone,
    emp_valid_from timestamp without time zone,
    emp_valid_till timestamp without time zone,
    emp_issuing_authority character varying(200) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_employeelicense ALTER COLUMN emp_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_employeelicense_emp_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_employeelicense
    ADD CONSTRAINT d_employeelicense_pkey PRIMARY KEY (emp_key);

ALTER TABLE ONLY dwh.d_employeelicense
    ADD CONSTRAINT d_employeelicense_ukey UNIQUE (emp_employee_code, emp_ou, emp_lineno);