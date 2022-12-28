CREATE TABLE stg.stg_wms_tariff_geo_hdr (
    wms_tr_geo_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_tr_geo_ou integer NOT NULL,
    wms_tr_geo_desc character varying(1020) COLLATE public.nocase,
    wms_tr_geo_status character varying(32) COLLATE public.nocase,
    wms_tr_geo_tartype character varying(32) COLLATE public.nocase,
    wms_tr_geo_div character varying(40) COLLATE public.nocase,
    wms_tr_geo_loc character varying(40) COLLATE public.nocase,
    wms_tr_geo_valid_id character varying(72) COLLATE public.nocase,
    wms_tr_geo_type character varying(32) COLLATE public.nocase,
    wms_tr_geo_code character varying(160) COLLATE public.nocase,
    wms_tr_geo_min_charge_app integer,
    wms_tr_geo_rate_type character varying(32) COLLATE public.nocase,
    wms_tr_geo_applied_tar_type character varying(32) COLLATE public.nocase,
    wms_tr_geo_applied_tar_id character varying(72) COLLATE public.nocase,
    wms_tr_geo_mul_lvl_apr integer,
    wms_tr_geo_timestamp integer,
    wms_tr_geo_created_by character varying(120) COLLATE public.nocase,
    wms_tr_geo_created_dt timestamp without time zone,
    wms_tr_geo_modified_by character varying(120) COLLATE public.nocase,
    wms_tr_geo_modified_dt timestamp without time zone,
    wms_tr_geo_previous_status character varying(32) COLLATE public.nocase,
    wms_tr_geo_tcdcode character varying(1020) COLLATE public.nocase,
    wms_tr_geo_var character varying(1020) COLLATE public.nocase,
    wms_tr_geo_dec_id character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_tariff_geo_hdr
    ADD CONSTRAINT wms_tariff_geo_hdr_pk PRIMARY KEY (wms_tr_geo_id, wms_tr_geo_ou);