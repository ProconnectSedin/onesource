CREATE TABLE stg.stg_client_service_log (
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

ALTER TABLE stg.stg_client_service_log ALTER COLUMN cust_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_client_service_log_cust_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY stg.stg_client_service_log
    ADD CONSTRAINT pk_client_1 PRIMARY KEY (cust_id);