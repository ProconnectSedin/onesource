CREATE TABLE stg.stg_pcsit_mast_key_value (
    cust_id integer NOT NULL,
    key character varying(400) COLLATE public.nocase,
    value character varying(400) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_pcsit_mast_key_value ALTER COLUMN cust_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_pcsit_mast_key_value_cust_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);