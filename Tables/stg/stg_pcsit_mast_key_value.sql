CREATE TABLE stg.stg_pcsit_mast_key_value (
    cust_id integer NOT NULL,
    key character varying(400) COLLATE public.nocase,
    value character varying(400) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);