CREATE TABLE stg.stg_ramco_service_master (
    rowid integer NOT NULL,
    service_id integer,
    service_name character varying(50) COLLATE public.nocase,
    url character varying(150) COLLATE public.nocase,
    servicetype character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_ramco_service_master ALTER COLUMN rowid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_ramco_service_master_rowid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY stg.stg_ramco_service_master
    ADD CONSTRAINT pk_ramco_service_master PRIMARY KEY (rowid);