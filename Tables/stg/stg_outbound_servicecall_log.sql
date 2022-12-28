CREATE TABLE stg.stg_outbound_servicecall_log (
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

ALTER TABLE stg.stg_outbound_servicecall_log ALTER COLUMN ob_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_outbound_servicecall_log_ob_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);