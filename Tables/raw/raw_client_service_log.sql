-- Table: raw.raw_client_service_log

-- DROP TABLE IF EXISTS "raw".raw_client_service_log;

CREATE TABLE IF NOT EXISTS "raw".raw_client_service_log
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    cust_id integer NOT NULL,
    client_name character varying(50) COLLATE public.nocase,
    service_name character varying(50) COLLATE public.nocase,
    service_type character varying(50) COLLATE public.nocase,
    client_json text COLLATE pg_catalog."default",
    status character varying(50) COLLATE public.nocase,
    error_message text COLLATE pg_catalog."default",
    key_search1 character varying(50) COLLATE public.nocase,
    key_search2 character varying(50) COLLATE public.nocase,
    key_search3 character varying(50) COLLATE public.nocase,
    key_search4 character varying(50) COLLATE public.nocase,
    ip_address character varying(20) COLLATE public.nocase,
    created_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_client_service_log_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_client_service_log
    OWNER to proconnect;