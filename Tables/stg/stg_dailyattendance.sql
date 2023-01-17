-- Table: stg.stg_dailyattendance

-- DROP TABLE IF EXISTS stg.stg_dailyattendance;

CREATE TABLE IF NOT EXISTS stg.stg_dailyattendance
(
    ou integer,
    attendance_date timestamp without time zone,
    location_code character varying(200) COLLATE pg_catalog."default",
    location_name character varying(200) COLLATE pg_catalog."default",
    employee_code character varying(200) COLLATE pg_catalog."default",
    employee_name character varying(200) COLLATE pg_catalog."default",
    dpeartment_name character varying(200) COLLATE pg_catalog."default",
    job_title character varying(300) COLLATE pg_catalog."default",
    category_name character varying(300) COLLATE pg_catalog."default",
    shift_start_time timestamp without time zone,
    shift_end_time timestamp without time zone,
    punch_in_time timestamp without time zone,
    punch_out_time timestamp without time zone,
    break_out_time timestamp without time zone,
    break_in_time timestamp without time zone,
    came_late_by integer,
    left_early_by integer,
    break_out_early_by integer,
    break_in_late_by integer,
    attendance_status character varying(200) COLLATE pg_catalog."default",
    work_hours integer,
    work_location_name character varying(300) COLLATE pg_catalog."default",
    last_updated_ts timestamp without time zone,
    shift_name character varying(200) COLLATE pg_catalog."default",
    normal_ot integer,
    night_ot integer,
    weekoff_ot integer,
    holiday_ot integer,
    approved_ot integer,
    custom_menu character varying(200) COLLATE pg_catalog."default",
    account_no character varying(200) COLLATE pg_catalog."default",
    inserted_ts timestamp without time zone,
    dept_code character varying(200) COLLATE pg_catalog."default",
    job_code character varying(200) COLLATE pg_catalog."default",
    job_eeo_class character varying(200) COLLATE pg_catalog."default",
    job_grade_set_code character varying(200) COLLATE pg_catalog."default",
    job_grade_code character varying(200) COLLATE pg_catalog."default",
    budgeted_count real,
    budgeted_ctc real,
    rqd_count_day real,
    shift_1 real,
    shift_2 real,
    shift_3 real,
    general real,
    createdatetime timestamp without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_dailyattendance
    OWNER to proconnect;