CREATE TABLE raw.raw_pcsit_loc_holiday_mst (
    raw_id bigint NOT NULL,
    locationcode character varying(250) COLLATE public.nocase,
    holidaydate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);