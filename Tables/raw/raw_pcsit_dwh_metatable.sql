CREATE TABLE raw.raw_pcsit_dwh_metatable (
    raw_id bigint NOT NULL,
    tranou integer,
    actiontype character varying(30) COLLATE public.nocase,
    actionpoint character varying(30) COLLATE public.nocase,
    last_updated_datetime timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);