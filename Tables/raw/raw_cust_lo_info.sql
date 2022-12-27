CREATE TABLE raw.raw_cust_lo_info (
    raw_id bigint NOT NULL,
    clo_lo character varying(80) NOT NULL COLLATE public.nocase,
    clo_cust_code character varying(72) NOT NULL COLLATE public.nocase,
    clo_cust_name character varying(160) NOT NULL COLLATE public.nocase,
    clo_cust_name_shd character varying(160) NOT NULL COLLATE public.nocase,
    clo_created_at integer NOT NULL,
    clo_registration_dt timestamp without time zone NOT NULL,
    clo_portal_user character varying(120) COLLATE public.nocase,
    clo_prosp_cust_code character varying(72) COLLATE public.nocase,
    clo_parent_cust_code character varying(72) COLLATE public.nocase,
    clo_supp_code character varying(64) COLLATE public.nocase,
    clo_number_type character varying(40) NOT NULL COLLATE public.nocase,
    clo_addrline1 character varying(600) COLLATE public.nocase,
    clo_addrline2 character varying(600) COLLATE public.nocase,
    clo_addrline3 character varying(600) COLLATE public.nocase,
    clo_city character varying(160) COLLATE public.nocase,
    clo_state character varying(160) COLLATE public.nocase,
    clo_country character(20) COLLATE public.nocase,
    clo_zip character varying(80) COLLATE public.nocase,
    clo_phone1 character varying(1020) COLLATE public.nocase,
    clo_phone2 character varying(1020) COLLATE public.nocase,
    clo_mobile character varying(1020) COLLATE public.nocase,
    clo_fax character varying(1020) COLLATE public.nocase,
    clo_email character varying(1020) COLLATE public.nocase,
    clo_url character varying(200) COLLATE public.nocase,
    clo_cr_chk_at character varying(32) NOT NULL COLLATE public.nocase,
    clo_nature_of_cust character varying(32) NOT NULL COLLATE public.nocase,
    clo_internal_bu character varying(80) COLLATE public.nocase,
    clo_internal_company character varying(40) COLLATE public.nocase,
    clo_account_group_code character varying(80) COLLATE public.nocase,
    clo_created_by character varying(120) NOT NULL COLLATE public.nocase,
    clo_created_date timestamp without time zone NOT NULL,
    clo_modified_by character varying(120) NOT NULL COLLATE public.nocase,
    clo_modified_date timestamp without time zone NOT NULL,
    clo_timestamp_value integer NOT NULL,
    clo_addnl1 character varying(1020) COLLATE public.nocase,
    clo_addnl2 character varying(1020) COLLATE public.nocase,
    clo_addnl3 integer,
    clo_cust_long_desc character varying(1024) COLLATE public.nocase,
    clo_noc character varying(32) DEFAULT 'ET'::character varying NOT NULL COLLATE public.nocase,
    clo_template character varying(4) COLLATE public.nocase,
    clo_registration_no character varying(72) COLLATE public.nocase,
    clo_registration_type character varying(160) COLLATE public.nocase,
    clo_pannumber character varying(40) COLLATE public.nocase,
    clo_noc_onetime character varying(32) COLLATE public.nocase,
    clo_cust_price_grp character varying(24) COLLATE public.nocase,
    clo_cust_tax_grp character varying(24) COLLATE public.nocase,
    clo_cust_disc_grp character varying(24) COLLATE public.nocase,
    clo_job_tilte character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_cust_lo_info ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_cust_lo_info_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_cust_lo_info
    ADD CONSTRAINT raw_cust_lo_info_pkey PRIMARY KEY (raw_id);