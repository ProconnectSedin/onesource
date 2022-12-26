CREATE TABLE stg.stg_client_service_manual (
    id integer NOT NULL,
    client_json character varying COLLATE public.nocase,
    serviceurl character varying(200) COLLATE public.nocase,
    servicename character varying(200) COLLATE public.nocase,
    status character varying(100) COLLATE public.nocase,
    refno character varying(200) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);