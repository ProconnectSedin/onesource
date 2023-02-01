-- Table: click.f_attrition

-- DROP TABLE IF EXISTS click.f_attrition;

CREATE TABLE IF NOT EXISTS click.f_attrition
(
    attrition_key bigint NOT NULL,
    loc_key bigint NOT NULL,
    emp_key bigint NOT NULL,
    supp_key bigint NOT NULL,
    wh_key bigint NOT NULL,
    ou integer,
    attendance_month timestamp without time zone,
    vendor_code character varying(200) COLLATE public.nocase,
    location_code character varying(200) COLLATE public.nocase,
    employee_type2 character varying(200) COLLATE public.nocase,
    vendor_name character varying(200) COLLATE public.nocase,
    warehouse_code character varying(200) COLLATE public.nocase,
    warehouse_name character varying(200) COLLATE public.nocase,
    employee_code character varying(200) COLLATE public.nocase,
    job_code character varying(200) COLLATE public.nocase,
    job_title character varying(200) COLLATE public.nocase,
    emp_count integer,
    addition integer,
    seperation integer,
    inserted_ts timestamp without time zone,
    stg_createddatetime timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    createddate timestamp(3) without time zone,
    updatedatetime timestamp(3) without time zone,
    CONSTRAINT f_attrition_pkey PRIMARY KEY (attrition_key),
    CONSTRAINT f_attrition_ukey UNIQUE (ou, attendance_month, vendor_code, location_code, warehouse_code, employee_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_attrition
    OWNER to proconnect;