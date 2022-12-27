CREATE TABLE dwh.d_employeeunavdate (
    emp_udate_key bigint NOT NULL,
    emp_employee_code character varying(40) COLLATE public.nocase,
    emp_ou integer,
    emp_lineno integer,
    emp_from_date timestamp without time zone,
    emp_to_date timestamp without time zone,
    emp_reason_code character varying(80) COLLATE public.nocase,
    emp_all_shift integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_employeeunavdate ALTER COLUMN emp_udate_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_employeeunavdate_emp_udate_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_employeeunavdate
    ADD CONSTRAINT d_employeeunavdate_pkey PRIMARY KEY (emp_udate_key);

ALTER TABLE ONLY dwh.d_employeeunavdate
    ADD CONSTRAINT d_employeeunavdate_ukey UNIQUE (emp_employee_code, emp_lineno, emp_ou);