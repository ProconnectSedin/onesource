CREATE TABLE raw.raw_co_useracess (
    raw_id bigint NOT NULL,
    username character varying(100) COLLATE public.nocase,
    reportname character varying(100) COLLATE public.nocase,
    reportdatetime timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);