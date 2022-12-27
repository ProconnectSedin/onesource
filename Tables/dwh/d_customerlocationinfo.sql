CREATE TABLE dwh.d_customerlocationinfo (
    clo_key bigint NOT NULL,
    clo_lo character varying(40) COLLATE public.nocase,
    clo_cust_code character varying(40) COLLATE public.nocase,
    clo_cust_name character varying(100) COLLATE public.nocase,
    clo_cust_name_shd character varying(100) COLLATE public.nocase,
    clo_created_at integer,
    clo_registration_dt timestamp without time zone,
    clo_portal_user character varying(100) COLLATE public.nocase,
    clo_prosp_cust_code character varying(40) COLLATE public.nocase,
    clo_parent_cust_code character varying(40) COLLATE public.nocase,
    clo_supp_code character varying(40) COLLATE public.nocase,
    clo_number_type character varying(20) COLLATE public.nocase,
    clo_addrline1 character varying(500) COLLATE public.nocase,
    clo_addrline2 character varying(500) COLLATE public.nocase,
    clo_addrline3 character varying(500) COLLATE public.nocase,
    clo_city character varying(100) COLLATE public.nocase,
    clo_state character varying(100) COLLATE public.nocase,
    clo_country character varying(20) COLLATE public.nocase,
    clo_zip character varying(40) COLLATE public.nocase,
    clo_phone1 character varying(500) COLLATE public.nocase,
    clo_phone2 character varying(500) COLLATE public.nocase,
    clo_mobile character varying(500) COLLATE public.nocase,
    clo_fax character varying(500) COLLATE public.nocase,
    clo_email character varying(500) COLLATE public.nocase,
    clo_url character varying(100) COLLATE public.nocase,
    clo_cr_chk_at character varying(20) COLLATE public.nocase,
    clo_nature_of_cust character varying(20) COLLATE public.nocase,
    clo_internal_bu character varying(40) COLLATE public.nocase,
    clo_internal_company character varying(20) COLLATE public.nocase,
    clo_account_group_code character varying(40) COLLATE public.nocase,
    clo_created_by character varying(100) COLLATE public.nocase,
    clo_created_date timestamp without time zone,
    clo_modified_by character varying(100) COLLATE public.nocase,
    clo_modified_date timestamp without time zone,
    clo_timestamp_value integer,
    clo_cust_long_desc character varying(500) COLLATE public.nocase,
    clo_noc character varying(20) COLLATE public.nocase,
    clo_template character varying(10) COLLATE public.nocase,
    clo_pannumber character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_customerlocationinfo ALTER COLUMN clo_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_customerlocationinfo_clo_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_customerlocationinfo
    ADD CONSTRAINT d_customerlocationinfo_pkey PRIMARY KEY (clo_key);

ALTER TABLE ONLY dwh.d_customerlocationinfo
    ADD CONSTRAINT d_customerlocationinfo_ukey UNIQUE (clo_lo, clo_cust_code);