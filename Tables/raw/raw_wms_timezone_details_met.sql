CREATE TABLE raw.raw_wms_timezone_details_met (
    raw_id bigint NOT NULL,
    wms_time_zone_id character varying(160) NOT NULL COLLATE public.nocase,
    wms_time_zone_display_name character varying(1020) NOT NULL COLLATE public.nocase,
    wms_timezoneoffset_fromutc character varying(160) COLLATE public.nocase,
    wms_hasdst integer,
    wms_isapplicable character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_timezone_details_met ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_timezone_details_met_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_timezone_details_met
    ADD CONSTRAINT raw_wms_timezone_details_met_pkey PRIMARY KEY (raw_id);