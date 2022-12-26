CREATE TABLE raw.raw_rt_courier_code (
    raw_id bigint NOT NULL,
    row_id integer NOT NULL,
    tms_vendor_code character varying(100) COLLATE public.nocase,
    plant_code character varying(100) COLLATE public.nocase,
    vendor_name character varying(50) COLLATE public.nocase,
    courier_code character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);