CREATE TABLE raw.raw_wms_vendor_location_division_dtl (
    raw_id bigint NOT NULL,
    wms_vendor_id character varying(64) NOT NULL COLLATE public.nocase,
    wms_vendor_ou integer NOT NULL,
    wms_vendor_lineno integer NOT NULL,
    wms_vendor_type character varying(32) COLLATE public.nocase,
    wms_vendor_code character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_vendor_location_division_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_vendor_location_division_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_vendor_location_division_dtl
    ADD CONSTRAINT raw_wms_vendor_location_division_dtl_pkey PRIMARY KEY (raw_id);