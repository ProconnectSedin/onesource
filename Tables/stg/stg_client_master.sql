CREATE TABLE stg.stg_client_master (
    rowid integer NOT NULL,
    client_id integer NOT NULL,
    client_code character varying(50) COLLATE public.nocase,
    client_name character varying(50) COLLATE public.nocase,
    clienttype character varying(50) COLLATE public.nocase,
    isonboarded integer NOT NULL,
    baseurl character varying(150) NOT NULL COLLATE public.nocase,
    is_deleted integer,
    deleted_by character varying(50) COLLATE public.nocase,
    deleted_date timestamp without time zone,
    updated_by character varying(50) COLLATE public.nocase,
    updated_date timestamp without time zone,
    created_by character varying(50) COLLATE public.nocase,
    created_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_client_master ALTER COLUMN rowid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_client_master_rowid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY stg.stg_client_master
    ADD CONSTRAINT pk_client_master PRIMARY KEY (rowid);