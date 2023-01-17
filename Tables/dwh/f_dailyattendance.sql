-- Table: dwh.f_dailyattendance

-- DROP TABLE IF EXISTS dwh.f_dailyattendance;

CREATE TABLE IF NOT EXISTS dwh.f_dailyattendance
(
    dailyattendance_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    loc_key bigint NOT NULL,
    date_key bigint NOT NULL,
    emp_key bigint NOT NULL,
    ou integer,
    attendance_date timestamp without time zone,
    location_code character varying(200) COLLATE public.nocase,
    location_name character varying(200) COLLATE public.nocase,
    employee_code character varying(200) COLLATE public.nocase,
    employee_name character varying(200) COLLATE public.nocase,
    dpeartment_name character varying(200) COLLATE public.nocase,
    job_title character varying(300) COLLATE public.nocase,
    category_name character varying(300) COLLATE public.nocase,
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
    attendance_status character varying(200) COLLATE public.nocase,
    work_hours integer,
    work_location_name character varying(300) COLLATE public.nocase,
    last_updated_ts timestamp without time zone,
    shift_name character varying(200) COLLATE public.nocase,
    normal_ot integer,
    night_ot integer,
    weekoff_ot integer,
    holiday_ot integer,
    approved_ot integer,
    custom_menu character varying(200) COLLATE public.nocase,
    account_no character varying(200) COLLATE public.nocase,
    inserted_ts timestamp without time zone,
    dept_code character varying(200) COLLATE public.nocase,
    job_code character varying(200) COLLATE public.nocase,
    job_eeo_class character varying(200) COLLATE public.nocase,
    job_grade_set_code character varying(200) COLLATE public.nocase,
    job_grade_code character varying(200) COLLATE public.nocase,
    budgeted_count real,
    budgeted_ctc real,
    rqd_count_day real,
    shift_1 real,
    shift_2 real,
    shift_3 real,
    general real,
    createdatetime timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_dailyattendance_pkey PRIMARY KEY (dailyattendance_key),
    CONSTRAINT f_dailyattendance_ukey UNIQUE (ou, attendance_date, employee_code),
    CONSTRAINT f_dailyattendance_date_key_fkey FOREIGN KEY (date_key)
        REFERENCES dwh.d_date (datekey) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_dailyattendance_emp_key_fkey FOREIGN KEY (emp_key)
        REFERENCES dwh.d_employeeheader (emp_hdr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_dailyattendance_loc_key_fkey FOREIGN KEY (loc_key)
        REFERENCES dwh.d_location (loc_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_dailyattendance
    OWNER to proconnect;
-- Index: f_dailyattendance_key_idx

-- DROP INDEX IF EXISTS dwh.f_dailyattendance_key_idx;

CREATE INDEX IF NOT EXISTS f_dailyattendance_key_idx
    ON dwh.f_dailyattendance USING btree
    (ou ASC NULLS LAST, attendance_date ASC NULLS LAST, employee_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;