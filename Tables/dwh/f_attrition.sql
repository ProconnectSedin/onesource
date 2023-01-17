-- Table: dwh.f_attrition

-- DROP TABLE IF EXISTS dwh.f_attrition;

CREATE TABLE IF NOT EXISTS dwh.f_attrition
(
    attrition_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    createddatetime timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_attrition_pkey PRIMARY KEY (attrition_key),
    CONSTRAINT f_attrition_ukey UNIQUE (ou, attendance_month, vendor_code, location_code, warehouse_code, employee_code),
    CONSTRAINT f_attrition_emp_key_fkey FOREIGN KEY (emp_key)
        REFERENCES dwh.d_employeeheader (emp_hdr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_attrition_loc_key_fkey FOREIGN KEY (loc_key)
        REFERENCES dwh.d_location (loc_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_attrition_supp_key_fkey FOREIGN KEY (supp_key)
        REFERENCES dwh.d_vendor (vendor_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_attrition_wh_key_fkey FOREIGN KEY (wh_key)
        REFERENCES dwh.d_warehouse (wh_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_attrition
    OWNER to proconnect;