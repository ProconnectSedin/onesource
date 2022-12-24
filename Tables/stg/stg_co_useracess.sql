CREATE TABLE stg.stg_co_useracess (
    username character varying(100) COLLATE public.nocase,
    reportname character varying(100) COLLATE public.nocase,
    reportdatetime timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);