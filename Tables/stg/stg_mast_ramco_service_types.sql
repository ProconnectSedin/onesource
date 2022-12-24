CREATE TABLE stg.stg_mast_ramco_service_types (
    rowid integer NOT NULL,
    cus_code character varying(50) COLLATE public.nocase,
    carrier_name character varying(1000) COLLATE public.nocase,
    service_type character varying(1000) COLLATE public.nocase,
    sub_service_type character varying(1000) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);