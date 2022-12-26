CREATE TABLE raw.raw_client_service_log (
    raw_id bigint NOT NULL,
    cust_id integer NOT NULL,
    client_name character varying(50) COLLATE public.nocase,
    service_name character varying(50) COLLATE public.nocase,
    service_type character varying(50) COLLATE public.nocase,
    client_json text,
    status character varying(50) COLLATE public.nocase,
    error_massage text,
    key_search1 character varying(50) COLLATE public.nocase,
    key_search2 character varying(50) COLLATE public.nocase,
    key_search3 character varying(50) COLLATE public.nocase,
    key_search4 character varying(50) COLLATE public.nocase,
    ip_address character varying(20) COLLATE public.nocase,
    created_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);