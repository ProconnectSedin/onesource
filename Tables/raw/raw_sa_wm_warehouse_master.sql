CREATE TABLE raw.raw_sa_wm_warehouse_master (
    raw_id bigint NOT NULL,
    wm_wh_code character varying(40) NOT NULL COLLATE public.nocase,
    wm_wh_ou integer NOT NULL,
    wm_wh_desc character varying(160) NOT NULL COLLATE public.nocase,
    wm_wh_status character(8) NOT NULL COLLATE public.nocase,
    wm_wh_desc_shdw character varying(160) NOT NULL COLLATE public.nocase,
    wm_wh_storage_type character(8) NOT NULL COLLATE public.nocase,
    wm_reason_code character varying(40) COLLATE public.nocase,
    wm_supervisor character varying(280) COLLATE public.nocase,
    wm_nettable integer,
    wm_finance_book character varying(80) COLLATE public.nocase,
    wm_allocation_method character(8) COLLATE public.nocase,
    wm_site_code character varying(40) NOT NULL COLLATE public.nocase,
    wm_address1 character varying(160) NOT NULL COLLATE public.nocase,
    wm_capital_warehouse integer,
    wm_address2 character varying(160) COLLATE public.nocase,
    wm_city character varying(160) COLLATE public.nocase,
    wm_all_trans_allowed integer,
    wm_state character varying(160) COLLATE public.nocase,
    wm_all_itemtypes_allowed integer,
    wm_zip_code character varying(80) COLLATE public.nocase,
    wm_all_stk_status_allowed integer,
    wm_country character varying(160) COLLATE public.nocase,
    wm_created_by character varying(120) NOT NULL COLLATE public.nocase,
    wm_created_dt timestamp without time zone NOT NULL,
    wm_modified_by character varying(120) COLLATE public.nocase,
    wm_modified_dt timestamp without time zone,
    wm_timestamp_value integer NOT NULL,
    wm_tran_type character varying(80) COLLATE public.nocase,
    wm_length numeric,
    wm_breadth numeric,
    wm_height numeric,
    wm_dimen_uom character varying(40) COLLATE public.nocase,
    wm_volume numeric,
    wm_volume_uom character varying(40) COLLATE public.nocase,
    wm_area numeric,
    wm_area_uom character varying(40) COLLATE public.nocase,
    wm_capacity numeric,
    wm_capacity_uom character varying(40) COLLATE public.nocase,
    wm_last_gen_zone character varying(40) COLLATE public.nocase,
    wm_last_gen_row character varying(40) COLLATE public.nocase,
    wm_last_gen_rack character varying(40) COLLATE public.nocase,
    wm_last_gen_level character varying(40) COLLATE public.nocase,
    wm_last_gen_bin character varying(40) COLLATE public.nocase,
    wm_bonded_yn character(12) COLLATE public.nocase,
    wm_customer_code character varying(160) COLLATE public.nocase,
    wm_structure character varying(100) COLLATE public.nocase,
    wm_valid_from timestamp without time zone,
    wm_valid_to timestamp without time zone,
    wm_gcp integer,
    wm_latitude numeric,
    wm_longitude numeric,
    location_code character varying(64) COLLATE public.nocase,
    location_desc character varying(1020) COLLATE public.nocase,
    wm_address3 character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_sa_wm_warehouse_master ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_sa_wm_warehouse_master_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_sa_wm_warehouse_master
    ADD CONSTRAINT raw_sa_wm_warehouse_master_pkey PRIMARY KEY (raw_id);