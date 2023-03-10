CREATE TABLE stg.stg_cust_prospect_info (
    cpr_lo character varying(80) NOT NULL COLLATE public.nocase,
    cpr_prosp_cust_code character varying(72) NOT NULL COLLATE public.nocase,
    cpr_prosp_cust_name character varying(160) NOT NULL COLLATE public.nocase,
    cpr_prosp_custname_shd character varying(160) NOT NULL COLLATE public.nocase,
    cpr_registration_dt timestamp without time zone NOT NULL,
    cpr_created_at integer NOT NULL,
    cpr_cust_code character varying(72) COLLATE public.nocase,
    cpr_number_type character varying(40) NOT NULL COLLATE public.nocase,
    cpr_parent_cust_code character varying(72) COLLATE public.nocase,
    cpr_created_transaction character varying(160) NOT NULL COLLATE public.nocase,
    cpr_supp_code character varying(64) COLLATE public.nocase,
    cpr_addrline1 character varying(400) COLLATE public.nocase,
    cpr_addrline2 character varying(160) COLLATE public.nocase,
    cpr_addrline3 character varying(160) COLLATE public.nocase,
    cpr_city character varying(160) COLLATE public.nocase,
    cpr_state character varying(160) COLLATE public.nocase,
    cpr_country character(20) COLLATE public.nocase,
    cpr_zip character varying(80) COLLATE public.nocase,
    cpr_phone1 character varying(1020) COLLATE public.nocase,
    cpr_phone2 character varying(1020) COLLATE public.nocase,
    cpr_mobile character varying(1020) COLLATE public.nocase,
    cpr_fax character varying(1020) COLLATE public.nocase,
    cpr_email character varying(1020) COLLATE public.nocase,
    cpr_url character varying(200) COLLATE public.nocase,
    cpr_status character varying(32) NOT NULL COLLATE public.nocase,
    cpr_created_by character varying(120) NOT NULL COLLATE public.nocase,
    cpr_created_date timestamp without time zone NOT NULL,
    cpr_modified_by character varying(120) NOT NULL COLLATE public.nocase,
    cpr_modified_date timestamp without time zone NOT NULL,
    cpr_timestamp_value integer NOT NULL,
    cpr_addnl1 character varying(1020) COLLATE public.nocase,
    cpr_addnl2 character varying(1020) COLLATE public.nocase,
    cpr_addnl3 integer,
    cpr_cont_person character varying(160) COLLATE public.nocase,
    cpr_prosp_long_desc character varying(1024) COLLATE public.nocase,
    cpr_industry character varying(20) COLLATE public.nocase,
    cpr_priority character varying(32) COLLATE public.nocase,
    cpr_region character varying(20) COLLATE public.nocase,
    cpr_prosp_contact_name character varying(160) COLLATE public.nocase,
    cpr_registration_no character varying(72) COLLATE public.nocase,
    cpr_registration_type character varying(160) COLLATE public.nocase,
    cpr_address_id character varying(24) COLLATE public.nocase,
    cpr_crm_flag character varying(80) COLLATE public.nocase,
    cpr_segment character varying(480) COLLATE public.nocase,
    cpr_sp_code character varying(480) COLLATE public.nocase,
    cpr_cust_loyalty character varying(480) COLLATE public.nocase,
    cpr_pannumber character varying(40) COLLATE public.nocase,
    cpr_job_title character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_cust_prospect_info
    ADD CONSTRAINT cust_prospect_info_pk PRIMARY KEY (cpr_lo, cpr_prosp_cust_code);