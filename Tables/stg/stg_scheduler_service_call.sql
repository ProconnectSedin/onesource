CREATE TABLE stg.stg_scheduler_service_call (
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

ALTER TABLE stg.stg_scheduler_service_call ALTER COLUMN scheduler_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_scheduler_service_call_scheduler_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY stg.stg_scheduler_service_call
    ADD CONSTRAINT pk_service_1 PRIMARY KEY (scheduler_id);