CREATE TABLE raw.raw_wms_bin_type_hdr (
    raw_id bigint NOT NULL,
    wms_bin_typ_ou integer NOT NULL,
    wms_bin_typ_code character varying(80) NOT NULL COLLATE public.nocase,
    wms_bin_typ_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_bin_typ_desc character varying(1020) COLLATE public.nocase,
    wms_bin_typ_status character varying(32) COLLATE public.nocase,
    wms_bin_typ_width numeric,
    wms_bin_typ_height numeric,
    wms_bin_typ_depth numeric,
    wms_bin_typ_dim_uom character varying(40) COLLATE public.nocase,
    wms_bin_typ_volume numeric,
    wms_bin_typ_vol_uom character varying(40) COLLATE public.nocase,
    wms_bin_typ_max_per_wt numeric,
    wms_bin_typ_max_wt_uom character varying(40) COLLATE public.nocase,
    wms_bin_typ_cap_indicator numeric,
    wms_bin_typ_user_def1 character varying(1020) COLLATE public.nocase,
    wms_bin_typ_user_def2 character varying(1020) COLLATE public.nocase,
    wms_bin_typ_user_def3 character varying(1020) COLLATE public.nocase,
    wms_bin_timestamp integer,
    wms_bin_created_by character varying(120) COLLATE public.nocase,
    wms_bin_created_dt timestamp without time zone,
    wms_bin_modified_by character varying(120) COLLATE public.nocase,
    wms_bin_modified_dt timestamp without time zone,
    wms_bin_one_bin_one_pal integer,
    wms_bin_typ_permitted_uids numeric,
    wms_bin_typ_one_bin numeric,
    wms_bin_typ_area numeric,
    wms_bin_typ_area_uom character varying(40) COLLATE public.nocase,
    wms_bin_typ_qty_capacity numeric,
    wms_bin_typ_prmtd_no_ethu integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_bin_type_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_bin_type_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_bin_type_hdr
    ADD CONSTRAINT raw_wms_bin_type_hdr_pkey PRIMARY KEY (raw_id);