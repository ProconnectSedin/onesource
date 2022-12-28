CREATE TABLE dwh.d_employeetype (
    emp_employee_key bigint NOT NULL,
    emp_employee_code character varying(40) COLLATE public.nocase,
    emp_ou integer,
    emp_lineno integer,
    emp_type character varying(80) COLLATE public.nocase,
    emp_priority character varying(80) COLLATE public.nocase,
    emp_mapped character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_employeetype ALTER COLUMN emp_employee_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_employeetype_emp_employee_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_employeetype
    ADD CONSTRAINT d_employeetype_pkey PRIMARY KEY (emp_employee_key);

ALTER TABLE ONLY dwh.d_employeetype
    ADD CONSTRAINT d_employeetype_ukey UNIQUE (emp_employee_code, emp_ou, emp_lineno);