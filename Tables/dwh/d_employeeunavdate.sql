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