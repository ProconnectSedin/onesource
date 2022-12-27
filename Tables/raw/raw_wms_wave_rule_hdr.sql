CREATE TABLE raw.raw_wms_wave_rule_hdr (
    raw_id bigint NOT NULL,
    wms_wave_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_wave_ou integer NOT NULL,
    wms_wave_open_order character varying(32) COLLATE public.nocase,
    wms_wave_dispatch_dt_from timestamp without time zone,
    wms_wave_dispatch_dt_to timestamp without time zone,
    wms_wave_order_dt_from timestamp without time zone,
    wms_wave_order_dt_to timestamp without time zone,
    wms_wave_alloc_rule character varying(1020) COLLATE public.nocase,
    wms_wave_alloc_value numeric,
    wms_wave_alloc_uom character varying(40) COLLATE public.nocase,
    wms_wave_auto_confirm integer,
    wms_wave_range_from_date timestamp without time zone,
    wms_wave_range_to_date timestamp without time zone,
    wms_wave_lines_per_wave integer,
    wms_wave_max_waves_per_day integer,
    wms_wave_no_of_pickers integer,
    wms_wave_pick_cycle_uom character varying(1020) COLLATE public.nocase,
    wms_wave_pick_cycle numeric,
    wms_wave_timestamp integer,
    wms_wave_created_by character varying(120) COLLATE public.nocase,
    wms_wave_created_date timestamp without time zone,
    wms_wave_modified_by character varying(120) COLLATE public.nocase,
    wms_wave_modified_date timestamp without time zone,
    wms_wave_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_wave_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_wave_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_wave_plnd_gd_iss_dt timestamp without time zone,
    wms_wave_ord_priority character varying(160) COLLATE public.nocase,
    wms_wave_schedule character varying(32) COLLATE public.nocase,
    wms_wave_cut_off_time1 timestamp without time zone,
    wms_wave_cut_off_time2 timestamp without time zone,
    wms_wave_cut_off_time3 timestamp without time zone,
    wms_wave_last_job_run timestamp without time zone,
    wms_wave_ex_critical_stock integer,
    wms_wave_zne_wise_cube integer,
    wms_wave_partial_waving character varying(32) COLLATE public.nocase,
    wms_wave_pick_consolidation character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_wave_rule_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_wave_rule_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_wave_rule_hdr
    ADD CONSTRAINT raw_wms_wave_rule_hdr_pkey PRIMARY KEY (raw_id);