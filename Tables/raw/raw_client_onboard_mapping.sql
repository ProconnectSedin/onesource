CREATE TABLE raw.raw_client_onboard_mapping (
    raw_id bigint NOT NULL,
    mapping_id integer NOT NULL,
    client_id integer NOT NULL,
    service_id integer NOT NULL,
    isactive integer NOT NULL,
    isfileprocess integer NOT NULL,
    targeturl character varying(250) NOT NULL COLLATE public.nocase,
    userid character varying(50) COLLATE public.nocase,
    userpassword character varying(50) COLLATE public.nocase,
    file_type character varying(10) COLLATE public.nocase,
    created_date timestamp without time zone,
    created_by character varying(50) COLLATE public.nocase,
    updated_date timestamp without time zone,
    updated_by character varying(50) COLLATE public.nocase,
    deleted_date timestamp without time zone,
    deleted_by character varying(50) COLLATE public.nocase,
    is_deleted integer,
    servicetype character varying(1000) COLLATE public.nocase,
    priority integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_client_onboard_mapping ALTER COLUMN mapping_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_client_onboard_mapping_mapping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_client_onboard_mapping ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_client_onboard_mapping_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_client_onboard_mapping
    ADD CONSTRAINT raw_client_onboard_mapping_pkey PRIMARY KEY (raw_id);