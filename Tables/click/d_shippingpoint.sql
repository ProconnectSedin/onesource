CREATE TABLE click.d_shippingpoint (
    shp_pt_key bigint NOT NULL,
    shp_pt_ou integer,
    shp_pt_id character varying(36) COLLATE public.nocase,
    shp_pt_desc character varying(300) COLLATE public.nocase,
    shp_pt_status character varying(16) COLLATE public.nocase,
    shp_pt_rsn_code character varying(80) COLLATE public.nocase,
    shp_pt_address1 character varying(200) COLLATE public.nocase,
    shp_pt_address2 character varying(200) COLLATE public.nocase,
    shp_pt_zipcode character varying(100) COLLATE public.nocase,
    shp_pt_city character varying(100) COLLATE public.nocase,
    shp_pt_state character varying(80) COLLATE public.nocase,
    shp_pt_country character varying(80) COLLATE public.nocase,
    shp_pt_email character varying(510) COLLATE public.nocase,
    shp_pt_timestamp integer,
    shp_pt_created_by character varying(60) COLLATE public.nocase,
    shp_pt_created_date timestamp without time zone,
    shp_pt_modified_by character varying(60) COLLATE public.nocase,
    shp_pt_modified_date timestamp without time zone,
    shp_pt_address3 character varying(200) COLLATE public.nocase,
    shp_pt_contact_person character varying(100) COLLATE public.nocase,
    shp_pt_fax character varying(80) COLLATE public.nocase,
    shp_pt_latitude numeric(13,2),
    shp_pt_longitude numeric(13,2),
    shp_pt_phone1 character varying(40) COLLATE public.nocase,
    shp_pt_phone2 character varying(40) COLLATE public.nocase,
    shp_pt_region character varying(80) COLLATE public.nocase,
    shp_pt_zone character varying(80),
    shp_pt_sub_zone character varying(80) COLLATE public.nocase,
    shp_pt_time_zone character varying(510) COLLATE public.nocase,
    shp_pt_url character varying(510) COLLATE public.nocase,
    shp_pt_suburb_code character varying(80) COLLATE public.nocase,
    shp_pt_time_slot numeric(13,2),
    shp_pt_time_slot_uom character varying(20) COLLATE public.nocase,
    shp_pt_wh character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_shippingpoint
    ADD CONSTRAINT d_shippingpoint_pkey PRIMARY KEY (shp_pt_key);

ALTER TABLE ONLY click.d_shippingpoint
    ADD CONSTRAINT d_shippingpoint_ukey UNIQUE (shp_pt_ou, shp_pt_id);