CREATE TABLE raw.raw_ramco_service_master (
    raw_id bigint NOT NULL,
    rowid integer NOT NULL,
    service_id integer,
    service_name character varying(50) COLLATE public.nocase,
    url character varying(150) COLLATE public.nocase,
    servicetype character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);