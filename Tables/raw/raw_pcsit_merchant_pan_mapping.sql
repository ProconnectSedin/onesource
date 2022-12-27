CREATE TABLE raw.raw_pcsit_merchant_pan_mapping (
    raw_id bigint NOT NULL,
    cust_code character(40) COLLATE public.nocase,
    cust_pan character varying(80) COLLATE public.nocase,
    status character(40) DEFAULT 'Y'::bpchar COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_merchant_pan_mapping ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_merchant_pan_mapping_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_merchant_pan_mapping
    ADD CONSTRAINT raw_pcsit_merchant_pan_mapping_pkey PRIMARY KEY (raw_id);