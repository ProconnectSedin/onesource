CREATE TABLE dwh.d_custprospectinfo (
    cpr_key bigint NOT NULL,
    cpr_lo character varying(40) COLLATE public.nocase,
    cpr_prosp_cust_code character varying(40) COLLATE public.nocase,
    cpr_prosp_cust_name character varying(80) COLLATE public.nocase,
    cpr_prosp_custname_shd character varying(80) COLLATE public.nocase,
    cpr_registration_dt timestamp without time zone,
    cpr_created_at integer,
    cpr_number_type character varying(20) COLLATE public.nocase,
    cpr_created_transaction character varying(100) COLLATE public.nocase,
    cpr_addrline1 character varying(200) COLLATE public.nocase,
    cpr_addrline2 character varying(100) COLLATE public.nocase,
    cpr_addrline3 character varying(100) COLLATE public.nocase,
    cpr_city character varying(100) COLLATE public.nocase,
    cpr_state character varying(100) COLLATE public.nocase,
    cpr_country character varying(10) COLLATE public.nocase,
    cpr_zip character varying(40) COLLATE public.nocase,
    cpr_phone1 character varying(500) COLLATE public.nocase,
    cpr_mobile character varying(500) COLLATE public.nocase,
    cpr_fax character varying(500) COLLATE public.nocase,
    cpr_email character varying(500) COLLATE public.nocase,
    cpr_status character varying(20) COLLATE public.nocase,
    cpr_created_by character varying(100) COLLATE public.nocase,
    cpr_created_date timestamp without time zone,
    cpr_modified_by character varying(100) COLLATE public.nocase,
    cpr_modified_date timestamp without time zone,
    cpr_timestamp_value integer,
    cpr_cont_person character varying(100) COLLATE public.nocase,
    cpr_prosp_long_desc character varying(500) COLLATE public.nocase,
    cpr_industry character varying(20) COLLATE public.nocase,
    cpr_priority character varying(20) COLLATE public.nocase,
    cpr_region character varying(20) COLLATE public.nocase,
    cpr_prosp_contact_name character varying(100) COLLATE public.nocase,
    cpr_registration_no character varying(40) COLLATE public.nocase,
    cpr_registration_type character varying(100) COLLATE public.nocase,
    cpr_address_id character varying(20) COLLATE public.nocase,
    cpr_crm_flag character varying(40) COLLATE public.nocase,
    cpr_segment character varying(250) COLLATE public.nocase,
    cpr_sp_code character varying(250) COLLATE public.nocase,
    cpr_cust_loyalty character varying(250) COLLATE public.nocase,
    cpr_pannumber character varying(20) COLLATE public.nocase,
    cpr_job_title character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_custprospectinfo ALTER COLUMN cpr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_custprospectinfo_cpr_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_custprospectinfo
    ADD CONSTRAINT d_custprospectinfo_pkey PRIMARY KEY (cpr_key);

ALTER TABLE ONLY dwh.d_custprospectinfo
    ADD CONSTRAINT d_custprospectinfo_ukey UNIQUE (cpr_lo, cpr_prosp_cust_code);