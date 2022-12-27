CREATE TABLE dwh.d_employeeskills (
    emp_skill_key bigint NOT NULL,
    emp_employee_code character varying(40) COLLATE public.nocase,
    emp_ou integer,
    emp_lineno integer,
    emp_skill_code character varying(80) COLLATE public.nocase,
    emp_primary_skill integer,
    emp_certificate_no character varying(510) COLLATE public.nocase,
    emp_certificate_type character varying(510) COLLATE public.nocase,
    emp_issued_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_employeeskills ALTER COLUMN emp_skill_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_employeeskills_emp_skill_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_employeeskills
    ADD CONSTRAINT d_employeeskills_pkey PRIMARY KEY (emp_skill_key);

ALTER TABLE ONLY dwh.d_employeeskills
    ADD CONSTRAINT d_employeeskills_ukey UNIQUE (emp_employee_code, emp_ou, emp_lineno);