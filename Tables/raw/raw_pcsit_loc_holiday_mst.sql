CREATE TABLE raw.raw_pcsit_loc_holiday_mst (
    raw_id bigint NOT NULL,
    locationcode character varying(250) COLLATE public.nocase,
    holidaydate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_loc_holiday_mst ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_loc_holiday_mst_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_loc_holiday_mst
    ADD CONSTRAINT raw_pcsit_loc_holiday_mst_pkey PRIMARY KEY (raw_id);