CREATE TABLE stg.stg_rt_courier_code (
    row_id integer NOT NULL,
    tms_vendor_code character varying(100) COLLATE public.nocase,
    plant_code character varying(100) COLLATE public.nocase,
    vendor_name character varying(50) COLLATE public.nocase,
    courier_code character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_rt_courier_code ALTER COLUMN row_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_rt_courier_code_row_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);