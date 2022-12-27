CREATE TABLE raw.raw_ramco_service_master (
    raw_id bigint NOT NULL,
    rowid integer NOT NULL,
    service_id integer,
    service_name character varying(50) COLLATE public.nocase,
    url character varying(150) COLLATE public.nocase,
    servicetype character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_ramco_service_master ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_ramco_service_master_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_ramco_service_master ALTER COLUMN rowid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_ramco_service_master_rowid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_ramco_service_master
    ADD CONSTRAINT raw_ramco_service_master_pkey PRIMARY KEY (raw_id);