CREATE TABLE dwh.d_employeeheader (
    emp_hdr_key bigint NOT NULL,
    emp_employee_code character varying(40) COLLATE public.nocase,
    emp_ou integer,
    emp_description character varying(500) COLLATE public.nocase,
    emp_status character varying(20) COLLATE public.nocase,
    emp_reason_code character varying(100) COLLATE public.nocase,
    emp_first_name character varying(250) COLLATE public.nocase,
    emp_last_name character varying(250) COLLATE public.nocase,
    emp_middle_name character varying(250) COLLATE public.nocase,
    emp_ssn_id_no character varying(40) COLLATE public.nocase,
    emp_gender character varying(20) COLLATE public.nocase,
    emp_owner_type character varying(20) COLLATE public.nocase,
    emp_nationality character varying(80) COLLATE public.nocase,
    emp_agency_id character varying(40) COLLATE public.nocase,
    emp_religion character varying(500) COLLATE public.nocase,
    emp_agency_contact_num character varying(40) COLLATE public.nocase,
    emp_dob timestamp without time zone,
    emp_date_of_confirmation timestamp without time zone,
    emp_user character varying(60) COLLATE public.nocase,
    emp_department character varying(100) COLLATE public.nocase,
    emp_designation character varying(100) COLLATE public.nocase,
    emp_date_of_joining timestamp without time zone,
    emp_blood_group character varying(500) COLLATE public.nocase,
    emp_cost_center character varying(20) COLLATE public.nocase,
    emp_address_line1 character varying(300) COLLATE public.nocase,
    emp_address_line2 character varying(300) COLLATE public.nocase,
    emp_address_line3 character varying(300) COLLATE public.nocase,
    emp_city character varying(100) COLLATE public.nocase,
    emp_state character varying(100) COLLATE public.nocase,
    emp_country character varying(100) COLLATE public.nocase,
    emp_postal_code character varying(40) COLLATE public.nocase,
    emp_primary_phone character varying(40) COLLATE public.nocase,
    emp_secondary_phone character varying(40) COLLATE public.nocase,
    emp_email character varying(120) COLLATE public.nocase,
    emp_emergency_contact_pers character varying(500) COLLATE public.nocase,
    emp_emergency_relationship character varying(500) COLLATE public.nocase,
    emp_phone character varying(40) COLLATE public.nocase,
    emp_default_location character varying(20) COLLATE public.nocase,
    emp_current_location character varying(40) COLLATE public.nocase,
    emp_current_location_since timestamp without time zone,
    emp_shift_pref character varying(80) COLLATE public.nocase,
    emp_grade character varying(20) COLLATE public.nocase,
    emp_created_by character varying(60) COLLATE public.nocase,
    emp_created_date timestamp without time zone,
    emp_modified_by character varying(60) COLLATE public.nocase,
    emp_modified_date timestamp without time zone,
    emp_timestamp integer,
    emp_given_name character varying(80) COLLATE public.nocase,
    emp_gen_info_grade character varying(80) COLLATE public.nocase,
    emp_employment character varying(80) COLLATE public.nocase,
    emp_rate_tariffid character varying(500) COLLATE public.nocase,
    emp_intransit integer,
    emp_route character varying(40) COLLATE public.nocase,
    emp_and character varying(500) COLLATE public.nocase,
    emp_between character varying(500) COLLATE public.nocase,
    emp_rate_tariffcontid character varying(40) COLLATE public.nocase,
    emp_raise_int_drfbill integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_employeeheader ALTER COLUMN emp_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_employeeheader_emp_hdr_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_employeeheader
    ADD CONSTRAINT d_employeeheader_pkey PRIMARY KEY (emp_hdr_key);

ALTER TABLE ONLY dwh.d_employeeheader
    ADD CONSTRAINT d_employeeheader_ukey UNIQUE (emp_employee_code, emp_ou);