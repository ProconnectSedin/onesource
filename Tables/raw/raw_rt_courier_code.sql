CREATE TABLE raw.raw_rt_courier_code (
    raw_id bigint NOT NULL,
    row_id integer NOT NULL,
    tms_vendor_code character varying(100) COLLATE public.nocase,
    plant_code character varying(100) COLLATE public.nocase,
    vendor_name character varying(50) COLLATE public.nocase,
    courier_code character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_rt_courier_code ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_rt_courier_code_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_rt_courier_code ALTER COLUMN row_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_rt_courier_code_row_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_rt_courier_code
    ADD CONSTRAINT raw_rt_courier_code_pkey PRIMARY KEY (raw_id);