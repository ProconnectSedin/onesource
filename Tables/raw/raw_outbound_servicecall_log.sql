CREATE TABLE raw.raw_outbound_servicecall_log (
    raw_id bigint NOT NULL,
    ob_id integer NOT NULL,
    scheduler_id integer,
    status character varying(50) COLLATE public.nocase,
    target_playload text,
    response_message text,
    created_date timestamp without time zone,
    updated_by character varying(50) COLLATE public.nocase,
    updated_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);