CREATE TABLE stg.stg_wms_wave_location_control (
    wms_wave_ou integer NOT NULL,
    wms_wave_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_wave_status character varying(32) NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_wave_location_control
    ADD CONSTRAINT wms_wave_location_control_pk PRIMARY KEY (wms_wave_ou, wms_wave_loc_code);