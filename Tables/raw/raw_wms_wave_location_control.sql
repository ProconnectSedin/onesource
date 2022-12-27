CREATE TABLE raw.raw_wms_wave_location_control (
    raw_id bigint NOT NULL,
    wms_wave_ou integer NOT NULL,
    wms_wave_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_wave_status character varying(32) NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_wave_location_control ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_wave_location_control_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_wave_location_control
    ADD CONSTRAINT raw_wms_wave_location_control_pkey PRIMARY KEY (raw_id);