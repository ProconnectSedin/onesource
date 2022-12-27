CREATE TABLE dwh.d_bintypes (
    bin_typ_key bigint NOT NULL,
    bin_typ_ou integer,
    bin_typ_code character varying(40) COLLATE public.nocase,
    bin_typ_loc_code character varying(20) COLLATE public.nocase,
    bin_typ_desc character varying(510) COLLATE public.nocase,
    bin_typ_status character varying(20) COLLATE public.nocase,
    bin_typ_width numeric(20,2),
    bin_typ_height numeric(20,2),
    bin_typ_depth numeric(20,2),
    bin_typ_dim_uom character varying(20) COLLATE public.nocase,
    bin_typ_volume numeric(20,2),
    bin_typ_vol_uom character varying(20) COLLATE public.nocase,
    bin_typ_max_per_wt numeric(20,2),
    bin_typ_max_wt_uom character varying(20) COLLATE public.nocase,
    bin_typ_cap_indicator numeric(20,2),
    bin_timestamp integer,
    bin_created_by character varying(60) COLLATE public.nocase,
    bin_created_dt timestamp without time zone,
    bin_modified_by character varying(60) COLLATE public.nocase,
    bin_modified_dt timestamp without time zone,
    bin_one_bin_one_pal integer,
    bin_typ_one_bin numeric(20,2),
    bin_typ_area numeric(20,2),
    bin_typ_area_uom character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    bin_typ_div_code character varying(20),
    bin_typ_vol_actual numeric(20,2),
    bin_div_key bigint,
    bin_typ_vol_calc numeric(20,2)
);

ALTER TABLE dwh.d_bintypes ALTER COLUMN bin_typ_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_bintypes_bin_typ_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_bintypes
    ADD CONSTRAINT d_bintypes_pkey PRIMARY KEY (bin_typ_key);

ALTER TABLE ONLY dwh.d_bintypes
    ADD CONSTRAINT d_bintypes_ukey UNIQUE (bin_typ_ou, bin_typ_code, bin_typ_loc_code);