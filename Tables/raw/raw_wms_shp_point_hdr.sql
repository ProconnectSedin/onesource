CREATE TABLE raw.raw_wms_shp_point_hdr (
    raw_id bigint NOT NULL,
    wms_shp_pt_ou integer NOT NULL,
    wms_shp_pt_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_shp_pt_desc character varying(600) COLLATE public.nocase,
    wms_shp_pt_status character varying(32) COLLATE public.nocase,
    wms_shp_pt_rsn_code character varying(160) COLLATE public.nocase,
    wms_shp_pt_address1 character varying(400) COLLATE public.nocase,
    wms_shp_pt_address2 character varying(400) COLLATE public.nocase,
    wms_shp_pt_zipcode character varying(200) COLLATE public.nocase,
    wms_shp_pt_city character varying(200) COLLATE public.nocase,
    wms_shp_pt_state character varying(160) COLLATE public.nocase,
    wms_shp_pt_country character varying(160) COLLATE public.nocase,
    wms_shp_pt_email character varying(1020) COLLATE public.nocase,
    wms_shp_pt_timestamp integer,
    wms_shp_pt_created_by character varying(120) COLLATE public.nocase,
    wms_shp_pt_created_date timestamp without time zone,
    wms_shp_pt_modified_by character varying(120) COLLATE public.nocase,
    wms_shp_pt_modified_date timestamp without time zone,
    wms_shp_pt_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_shp_pt_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_shp_pt_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_shp_pt_address3 character varying(400) COLLATE public.nocase,
    wms_shp_pt_contact_person character varying(180) COLLATE public.nocase,
    wms_shp_pt_fax character varying(160) COLLATE public.nocase,
    wms_shp_pt_geo_fence_name character varying(160) COLLATE public.nocase,
    wms_shp_pt_geo_fence_range numeric,
    wms_shp_pt_geo_fence_type character varying(1020) COLLATE public.nocase,
    wms_shp_pt_latitude numeric,
    wms_shp_pt_longitude numeric,
    wms_shp_pt_phone1 character varying(72) COLLATE public.nocase,
    wms_shp_pt_phone2 character varying(72) COLLATE public.nocase,
    wms_shp_pt_region character varying(160) COLLATE public.nocase,
    wms_shp_pt_zone character varying(160) COLLATE public.nocase,
    wms_shp_pt_sub_zone character varying(160) COLLATE public.nocase,
    wms_shp_pt_time_zone character varying(1020) COLLATE public.nocase,
    wms_shp_pt_url character varying(1020) COLLATE public.nocase,
    wms_shp_pt_suburb_code character varying(160) COLLATE public.nocase,
    wms_shp_pt_time_slot numeric,
    wms_shp_pt_time_slot_uom character varying(40) COLLATE public.nocase,
    wms_shp_pt_congid character varying(72) COLLATE public.nocase,
    wms_shp_pt_wh character varying(40) COLLATE public.nocase,
    wms_shp_pt_type character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_shp_point_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_shp_point_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_shp_point_hdr
    ADD CONSTRAINT raw_wms_shp_point_hdr_pkey PRIMARY KEY (raw_id);