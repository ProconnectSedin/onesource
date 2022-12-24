CREATE TABLE raw.raw_pcsit_nethrapro_pod (
    raw_id bigint NOT NULL,
    row_id integer NOT NULL,
    orderno character varying(1000) COLLATE public.nocase,
    tripid character varying(1000) COLLATE public.nocase,
    url character varying(1000) COLLATE public.nocase,
    status character varying(1000) COLLATE public.nocase,
    create_date timestamp without time zone,
    update_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);