CREATE TABLE raw.raw_wms_employee_hdr (
    raw_id bigint NOT NULL,
    wms_emp_employee_code character varying(80) NOT NULL COLLATE public.nocase,
    wms_emp_ou integer NOT NULL,
    wms_emp_description character varying(1020) COLLATE public.nocase,
    wms_emp_status character varying(32) COLLATE public.nocase,
    wms_emp_reason_code character varying(160) COLLATE public.nocase,
    wms_emp_first_name character varying(308) COLLATE public.nocase,
    wms_emp_last_name character varying(308) COLLATE public.nocase,
    wms_emp_middle_name character varying(308) COLLATE public.nocase,
    wms_emp_group character varying(160) COLLATE public.nocase,
    wms_emp_ssn_id_no character varying(80) COLLATE public.nocase,
    wms_emp_gender character varying(32) COLLATE public.nocase,
    wms_emp_owner_type character varying(32) COLLATE public.nocase,
    wms_emp_nationality character varying(160) COLLATE public.nocase,
    wms_emp_agency_id character varying(72) COLLATE public.nocase,
    wms_emp_religion character varying(1020) COLLATE public.nocase,
    wms_emp_agency_contact_num character varying(72) COLLATE public.nocase,
    wms_emp_dob timestamp without time zone,
    wms_emp_effective_from timestamp without time zone,
    wms_emp_effective_to timestamp without time zone,
    wms_emp_date_of_confirmation timestamp without time zone,
    wms_emp_user character varying(120) COLLATE public.nocase,
    wms_emp_department character varying(160) COLLATE public.nocase,
    wms_emp_date_of_retirement timestamp without time zone,
    wms_emp_designation character varying(160) COLLATE public.nocase,
    wms_emp_date_of_joining timestamp without time zone,
    wms_emp_blood_group character varying(1020) COLLATE public.nocase,
    wms_emp_cost_center character varying(40) COLLATE public.nocase,
    wms_emp_height numeric,
    wms_emp_height_uom character varying(40) COLLATE public.nocase,
    wms_emp_weight numeric,
    wms_emp_weight_uom character varying(40) COLLATE public.nocase,
    wms_emp_address_line1 character varying(600) COLLATE public.nocase,
    wms_emp_address_line2 character varying(600) COLLATE public.nocase,
    wms_emp_address_line3 character varying(600) COLLATE public.nocase,
    wms_emp_unique_address_id character varying(72) COLLATE public.nocase,
    wms_emp_city character varying(160) COLLATE public.nocase,
    wms_emp_state character varying(160) COLLATE public.nocase,
    wms_emp_country character varying(160) COLLATE public.nocase,
    wms_emp_postal_code character varying(80) COLLATE public.nocase,
    wms_emp_primary_phone character varying(72) COLLATE public.nocase,
    wms_emp_secondary_phone character varying(72) COLLATE public.nocase,
    wms_emp_email character varying(240) COLLATE public.nocase,
    wms_emp_fax character varying(160) COLLATE public.nocase,
    wms_emp_emergency_contact_pers character varying(1020) COLLATE public.nocase,
    wms_emp_emergency_relationship character varying(1020) COLLATE public.nocase,
    wms_emp_phone character varying(72) COLLATE public.nocase,
    wms_emp_default_location character varying(40) COLLATE public.nocase,
    wms_emp_current_location character varying(72) COLLATE public.nocase,
    wms_emp_current_location_since timestamp without time zone,
    wms_emp_continuous_drive_hrs numeric,
    wms_emp_total_limit_day numeric,
    wms_emp_total_limit_week numeric,
    wms_emp_days_off_week numeric,
    wms_emp_work_days_week numeric,
    wms_emp_shift_pref character varying(160) COLLATE public.nocase,
    wms_emp_from_time timestamp without time zone,
    wms_emp_to_time timestamp without time zone,
    wms_emp_grade character varying(40) COLLATE public.nocase,
    wms_emp_preferred_handler character varying(160) COLLATE public.nocase,
    wms_emp_created_by character varying(120) COLLATE public.nocase,
    wms_emp_created_date timestamp without time zone,
    wms_emp_modified_by character varying(120) COLLATE public.nocase,
    wms_emp_modified_date timestamp without time zone,
    wms_emp_timestamp integer,
    wms_emp_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_emp_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_emp_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_emp_given_name character varying(160) COLLATE public.nocase,
    wms_emp_gen_info_grade character varying(160) COLLATE public.nocase,
    wms_emp_employment character varying(160) COLLATE public.nocase,
    wms_emp_rate_tariffid character varying(1020) COLLATE public.nocase,
    wms_emp_intransit integer,
    wms_emp_route character varying(72) COLLATE public.nocase,
    wms_emp_and character varying(1020) COLLATE public.nocase,
    wms_emp_between character varying(1020) COLLATE public.nocase,
    wms_emp_rate_tariffcontid character varying(72) COLLATE public.nocase,
    wms_emp_raise_int_drfbill integer,
    wms_emp_rest_day timestamp without time zone,
    wms_emp_last_bil_date timestamp without time zone,
    wms_emp_last_prev_bil_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_employee_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_employee_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_employee_hdr
    ADD CONSTRAINT raw_wms_employee_hdr_pkey PRIMARY KEY (raw_id);