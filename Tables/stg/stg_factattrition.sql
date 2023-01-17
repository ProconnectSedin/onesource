-- Table: stg.stg_factattrition

-- DROP TABLE IF EXISTS stg.stg_factattrition;

CREATE TABLE IF NOT EXISTS stg.stg_factattrition
(
    ou integer,
    attendance_month timestamp without time zone,
    vendor_code character varying(200) COLLATE pg_catalog."default",
    location_code character varying(200) COLLATE pg_catalog."default",
    employee_type2 character varying(200) COLLATE pg_catalog."default",
    vendor_name character varying(200) COLLATE pg_catalog."default",
    warehouse_code character varying(200) COLLATE pg_catalog."default",
    warehouse_name character varying(200) COLLATE pg_catalog."default",
    employee_code character varying(200) COLLATE pg_catalog."default",
    job_code character varying(200) COLLATE pg_catalog."default",
    job_title character varying(200) COLLATE pg_catalog."default",
    emp_count integer,
    addition integer,
    seperation integer,
    inserted_ts timestamp without time zone,
    createddatetime timestamp without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_factattrition
    OWNER to proconnect;