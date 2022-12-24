CREATE TABLE raw.raw_scheduler_service_call (
    raw_id bigint NOT NULL,
    scheduler_id integer NOT NULL,
    client_id integer NOT NULL,
    service_id integer NOT NULL,
    service_playload text NOT NULL,
    status character varying(30) COLLATE public.nocase,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    clientlogid integer,
    target_filename text,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);