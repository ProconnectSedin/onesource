CREATE TABLE raw.raw_wms_loc_location_hdr (
    raw_id bigint NOT NULL,
    wms_loc_ou integer NOT NULL,
    wms_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loc_desc character varying(1020) COLLATE public.nocase,
    wms_loc_status character varying(32) COLLATE public.nocase,
    wms_loc_type character varying(160) COLLATE public.nocase,
    wms_reason_code character varying(160) COLLATE public.nocase,
    wms_finance_book character varying(80) COLLATE public.nocase,
    wms_costcenter character varying(40) COLLATE public.nocase,
    wms_account_code character varying(128) COLLATE public.nocase,
    wms_address1 character varying(400) COLLATE public.nocase,
    wms_address2 character varying(400) COLLATE public.nocase,
    wms_country character varying(160) COLLATE public.nocase,
    wms_state character varying(160) COLLATE public.nocase,
    wms_city character varying(200) COLLATE public.nocase,
    wms_zip_code character varying(80) COLLATE public.nocase,
    wms_contperson character varying(180) COLLATE public.nocase,
    wms_contact_no character varying(200) COLLATE public.nocase,
    wms_email character varying(240) COLLATE public.nocase,
    wms_fax character varying(200) COLLATE public.nocase,
    wms_time_zone_id character varying(160) COLLATE public.nocase,
    wms_loc_lat numeric,
    wms_loc_long numeric,
    wms_user_def1 character varying(1020) COLLATE public.nocase,
    wms_user_def2 character varying(1020) COLLATE public.nocase,
    wms_user_def3 character varying(1020) COLLATE public.nocase,
    wms_timestamp integer,
    wms_created_by character varying(120) COLLATE public.nocase,
    wms_created_dt timestamp without time zone,
    wms_modified_by character varying(120) COLLATE public.nocase,
    wms_modified_dt timestamp without time zone,
    wms_def_plan_mode character varying(160) COLLATE public.nocase,
    wms_loc_shp_point character varying(160) COLLATE public.nocase,
    wms_loc_warhouse character varying(1020) COLLATE public.nocase,
    wms_loc_yard character varying(72) COLLATE public.nocase,
    wms_loc_veh_id character varying(1020) COLLATE public.nocase,
    wms_loc_veh_type character varying(1020) COLLATE public.nocase,
    wms_loc_auto_cr_tug_trip character varying(1020) COLLATE public.nocase,
    wms_loc_cubing integer,
    wms_loc_default_thu_id character varying(160) COLLATE public.nocase,
    wms_blanket_count_sa integer,
    wms_enable_uid_prof integer,
    wms_loc_linked_hub character varying(40) COLLATE public.nocase,
    wms_bank_code character varying(128) COLLATE public.nocase,
    wms_cash_code character varying(128) COLLATE public.nocase,
    wms_loc_default_ethu character varying(160) COLLATE public.nocase,
    wms_loc_enable_bin_chkbit integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_loc_location_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_loc_location_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_loc_location_hdr
    ADD CONSTRAINT raw_wms_loc_location_hdr_pkey PRIMARY KEY (raw_id);