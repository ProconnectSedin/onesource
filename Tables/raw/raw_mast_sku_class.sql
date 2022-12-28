CREATE TABLE raw.raw_mast_sku_class (
    raw_id bigint NOT NULL,
    rowid integer NOT NULL,
    customercode character varying(50) COLLATE public.nocase,
    materialgroup character varying(50) COLLATE public.nocase,
    sbucode character varying(50) COLLATE public.nocase,
    sbuname character varying(200) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_mast_sku_class ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_mast_sku_class_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_mast_sku_class ALTER COLUMN rowid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_mast_sku_class_rowid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_mast_sku_class
    ADD CONSTRAINT raw_mast_sku_class_pkey PRIMARY KEY (raw_id);