CREATE TABLE stg.stg_wms_timezone_details_met (
    wms_time_zone_id character varying(160) NOT NULL COLLATE public.nocase,
    wms_time_zone_display_name character varying(1020) NOT NULL COLLATE public.nocase,
    wms_timezoneoffset_fromutc character varying(160) COLLATE public.nocase,
    wms_hasdst integer,
    wms_isapplicable character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_timezone_details_met
    ADD CONSTRAINT wms_timezone_details_met_pk PRIMARY KEY (wms_time_zone_id, wms_time_zone_display_name);