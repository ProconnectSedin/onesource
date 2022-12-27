CREATE TABLE raw.raw_wms_bin_dtl (
    raw_id bigint NOT NULL,
    wms_bin_ou integer NOT NULL,
    wms_bin_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_bin_desc character varying(1020) NOT NULL COLLATE public.nocase,
    wms_bin_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_bin_zone character varying(40) NOT NULL COLLATE public.nocase,
    wms_bin_type character varying(1020) NOT NULL COLLATE public.nocase,
    wms_bin_cap_indicator numeric,
    wms_bin_aisle character varying(40) COLLATE public.nocase,
    wms_bin_stack character varying(40) COLLATE public.nocase,
    wms_bin_level character varying(40) COLLATE public.nocase,
    wms_bin_section character varying(40) COLLATE public.nocase,
    wms_bin_seq_no numeric,
    wms_bin_blocked character varying(32) COLLATE public.nocase,
    wms_bin_reason_code character varying(40) COLLATE public.nocase,
    wms_bin_user_def1 character varying(1020) COLLATE public.nocase,
    wms_bin_user_def2 character varying(1020) COLLATE public.nocase,
    wms_bin_user_def3 character varying(1020) COLLATE public.nocase,
    wms_bin_timestamp integer,
    wms_bin_created_by character varying(120) COLLATE public.nocase,
    wms_bin_created_dt timestamp without time zone,
    wms_bin_modified_by character varying(120) COLLATE public.nocase,
    wms_bin_modified_dt timestamp without time zone,
    wms_bin_status character varying(1020) COLLATE public.nocase,
    wms_bin_stock_exist character varying(32) COLLATE public.nocase,
    wms_bin_one_bin_one_pal integer,
    wms_bin_permitted_uids numeric,
    wms_bin_curr_plnno character varying(72) COLLATE public.nocase,
    wms_bin_curr_created_date timestamp without time zone,
    wms_bin_curr_created_time character varying(48) COLLATE public.nocase,
    wms_bin_last_plnno character varying(72) COLLATE public.nocase,
    wms_bin_last_created_date timestamp without time zone,
    wms_bin_last_created_time character varying(48) COLLATE public.nocase,
    wms_bin_anti_cap_ethu numeric,
    wms_bin_anti_cap_ci numeric,
    wms_bin_anti_cap_wgt numeric,
    wms_bin_anti_cap_qty numeric,
    wms_bin_anti_cap_vol numeric,
    wms_bin_rem_cap_qty numeric,
    wms_bin_rem_cap_ci numeric,
    wms_bin_rem_cap_ethu numeric,
    wms_bin_rem_cap_vol numeric,
    wms_bin_rem_cap_wgt numeric,
    wms_bin_blocking_reason_ml character varying(160) COLLATE public.nocase,
    wms_bin_blocked_pick_ml character varying(1020) COLLATE public.nocase,
    wms_bin_blocked_pawy_ml character varying(1020) COLLATE public.nocase,
    wms_bin_bin_checkbit_ml character varying(160) COLLATE public.nocase,
    wms_bin_bin_full_ml character varying(1020) COLLATE public.nocase,
    wms_bin_blocked_sa_ml character varying(1020) COLLATE public.nocase,
    wms_error_code character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_bin_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_bin_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_bin_dtl
    ADD CONSTRAINT raw_wms_bin_dtl_pkey PRIMARY KEY (raw_id);