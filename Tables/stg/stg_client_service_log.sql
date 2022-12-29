-- Table: stg.stg_client_service_log

-- DROP TABLE IF EXISTS stg.stg_client_service_log;

CREATE TABLE IF NOT EXISTS stg.stg_client_service_log
(
    cust_id integer NOT NULL,
    client_name character varying(50) COLLATE public.nocase,
    service_name character varying(50) COLLATE public.nocase,
    service_type character varying(50) COLLATE public.nocase,
    client_json text COLLATE public.nocase NOT NULL,
    status character varying(50) COLLATE public.nocase,
    error_message text COLLATE public.nocase,
    key_search1 character varying(50) COLLATE public.nocase,
    key_search2 character varying(50) COLLATE public.nocase,
    key_search3 character varying(50) COLLATE public.nocase,
    key_search4 character varying(50) COLLATE public.nocase,
    ip_address character varying(20) COLLATE public.nocase,
    created_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pk_client_1 PRIMARY KEY (cust_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_client_service_log
    OWNER to proconnect;