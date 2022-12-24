CREATE TABLE raw.raw_pcsit_mast_key_value (
    raw_id bigint NOT NULL,
    cust_id integer NOT NULL,
    key character varying(400) COLLATE public.nocase,
    value character varying(400) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);