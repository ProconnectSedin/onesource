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

ALTER TABLE raw.raw_scheduler_service_call ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_scheduler_service_call_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_scheduler_service_call ALTER COLUMN scheduler_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_scheduler_service_call_scheduler_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_scheduler_service_call
    ADD CONSTRAINT raw_scheduler_service_call_pkey PRIMARY KEY (raw_id);