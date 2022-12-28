CREATE TABLE raw.raw_wms_consignor_hdr (
    raw_id bigint NOT NULL,
    wms_consignor_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_consignor_ou integer NOT NULL,
    wms_consignor_desc character varying(600) COLLATE public.nocase,
    wms_consignor_status character varying(32) COLLATE public.nocase,
    wms_consignor_currency character(20) COLLATE public.nocase,
    wms_consignor_payterm character varying(60) COLLATE public.nocase,
    wms_consignor_reasoncode character varying(160) COLLATE public.nocase,
    wms_consignor_address1 character varying(400) COLLATE public.nocase,
    wms_consignor_address2 character varying(400) COLLATE public.nocase,
    wms_consignor_address3 character varying(400) COLLATE public.nocase,
    wms_consignor_uniqueaddressid character varying(72) COLLATE public.nocase,
    wms_consignor_city character varying(200) COLLATE public.nocase,
    wms_consignor_state character varying(160) COLLATE public.nocase,
    wms_consignor_country character varying(160) COLLATE public.nocase,
    wms_consignor_postalcode character varying(160) COLLATE public.nocase,
    wms_consignor_phone1 character varying(200) COLLATE public.nocase,
    wms_consignor_fax character varying(200) COLLATE public.nocase,
    wms_consignor_contactperson character varying(180) COLLATE public.nocase,
    wms_consignor_customer_id character varying(72) COLLATE public.nocase,
    wms_consignor_created_by character varying(120) COLLATE public.nocase,
    wms_consignor_created_date timestamp without time zone,
    wms_consignor_modified_by character varying(120) COLLATE public.nocase,
    wms_consignor_modified_date timestamp without time zone,
    wms_consignor_timestamp integer,
    wms_consignor_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_consignor_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_consignor_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_consignor_zone character varying(160) COLLATE public.nocase,
    wms_consignor_subzone character varying(160) COLLATE public.nocase,
    wms_consignor_region character varying(160) COLLATE public.nocase,
    wms_consignor_timezone character varying(1020) COLLATE public.nocase,
    wms_consignor_latitude numeric,
    wms_consignor_longitude numeric,
    wms_consignor_geofencerange numeric,
    wms_consignor_geofencename character varying(160) COLLATE public.nocase,
    wms_consignor_phone2 character varying(72) COLLATE public.nocase,
    wms_consignor_url character varying(1020) COLLATE public.nocase,
    wms_consignor_email character varying(240) COLLATE public.nocase,
    wms_consignor_uom character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_consignor_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_consignor_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_consignor_hdr
    ADD CONSTRAINT raw_wms_consignor_hdr_pkey PRIMARY KEY (raw_id);