CREATE TABLE raw.raw_wms_consignee_hdr (
    raw_id bigint NOT NULL,
    wms_consignee_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_consignee_ou integer NOT NULL,
    wms_consignee_desc character varying(600) COLLATE public.nocase,
    wms_consignee_status character varying(32) COLLATE public.nocase,
    wms_consignee_currency character(20) COLLATE public.nocase,
    wms_consignee_payterm character varying(60) COLLATE public.nocase,
    wms_consignee_reasoncode character varying(160) COLLATE public.nocase,
    wms_consignee_address1 character varying(400) COLLATE public.nocase,
    wms_consignee_address2 character varying(400) COLLATE public.nocase,
    wms_consignee_address3 character varying(400) COLLATE public.nocase,
    wms_consignee_uniqueaddressid character varying(72) COLLATE public.nocase,
    wms_consignee_city character varying(200) COLLATE public.nocase,
    wms_consignee_state character varying(160) COLLATE public.nocase,
    wms_consignee_country character varying(160) COLLATE public.nocase,
    wms_consignee_postalcode character varying(160) COLLATE public.nocase,
    wms_consignee_phone1 character varying(200) COLLATE public.nocase,
    wms_consignee_phone2 character varying(200) COLLATE public.nocase,
    wms_consignee_email character varying(240) COLLATE public.nocase,
    wms_consignee_customer_id character varying(72) COLLATE public.nocase,
    wms_consignee_created_by character varying(120) COLLATE public.nocase,
    wms_consignee_created_date timestamp without time zone,
    wms_consignee_modified_by character varying(120) COLLATE public.nocase,
    wms_consignee_modified_date timestamp without time zone,
    wms_consignee_timestamp integer,
    wms_consignee_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_consignee_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_consignee_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_consignee_zone character varying(160) COLLATE public.nocase,
    wms_consignee_subzone character varying(160) COLLATE public.nocase,
    wms_consignee_region character varying(160) COLLATE public.nocase,
    wms_consignee_timezone character varying(1020) COLLATE public.nocase,
    wms_consignee_latitude numeric,
    wms_consignee_longitude numeric,
    wms_consignee_geofencerange numeric,
    wms_consignee_uom character varying(1020) COLLATE public.nocase,
    wms_consignee_geofencename character varying(160) COLLATE public.nocase,
    wms_consignee_url character varying(1020) COLLATE public.nocase,
    wms_consignee_fax character varying(160) COLLATE public.nocase,
    wms_consignee_shippointid character varying(72) COLLATE public.nocase,
    wms_consignee_time_ordering character varying(32) COLLATE public.nocase,
    wms_consignee_timeslot character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_consignee_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_consignee_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_consignee_hdr
    ADD CONSTRAINT raw_wms_consignee_hdr_pkey PRIMARY KEY (raw_id);