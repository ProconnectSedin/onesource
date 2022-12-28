CREATE TABLE raw.raw_pcsit_mast_key_value (
    raw_id bigint NOT NULL,
    cust_id integer NOT NULL,
    key character varying(400) COLLATE public.nocase,
    value character varying(400) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_mast_key_value ALTER COLUMN cust_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_mast_key_value_cust_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_pcsit_mast_key_value ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_mast_key_value_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_mast_key_value
    ADD CONSTRAINT raw_pcsit_mast_key_value_pkey PRIMARY KEY (raw_id);