CREATE TABLE raw.raw_client_service_manual (
    raw_id bigint NOT NULL,
    client_json character varying COLLATE public.nocase,
    serviceurl character varying(200) COLLATE public.nocase,
    servicename character varying(200) COLLATE public.nocase,
    status character varying(100) COLLATE public.nocase,
    refno character varying(200) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_client_service_manual ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_client_service_manual_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_client_service_manual
    ADD CONSTRAINT raw_client_service_manual_pkey PRIMARY KEY (raw_id);