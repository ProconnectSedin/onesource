CREATE TABLE stg.stg_pcsit_loc_holiday_mst (
    id integer NOT NULL,
    locationcode character varying(250) COLLATE public.nocase,
    holidaydate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_pcsit_loc_holiday_mst ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_pcsit_loc_holiday_mst_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);