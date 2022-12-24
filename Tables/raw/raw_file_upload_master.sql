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