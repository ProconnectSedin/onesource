CREATE TABLE raw.raw_file_upload_master (
    raw_id bigint NOT NULL,
    upload_id integer NOT NULL,
    location character varying(50) DEFAULT ''::character varying NOT NULL COLLATE public.nocase,
    docket_no character varying(50) DEFAULT ''::character varying NOT NULL COLLATE public.nocase,
    invoice_no character varying(50) DEFAULT ''::character varying NOT NULL COLLATE public.nocase,
    trip_id character varying(150) DEFAULT ''::character varying NOT NULL COLLATE public.nocase,
    filename character varying(150) NOT NULL COLLATE public.nocase,
    created_by character varying(50) COLLATE public.nocase,
    created_date timestamp without time zone DEFAULT now(),
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_file_upload_master ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_file_upload_master_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_file_upload_master ALTER COLUMN upload_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_file_upload_master_upload_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_file_upload_master
    ADD CONSTRAINT raw_file_upload_master_pkey PRIMARY KEY (raw_id);