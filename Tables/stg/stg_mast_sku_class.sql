CREATE TABLE stg.stg_mast_sku_class (
    rowid integer NOT NULL,
    customercode character varying(50) COLLATE public.nocase,
    materialgroup character varying(50) COLLATE public.nocase,
    sbucode character varying(50) COLLATE public.nocase,
    sbuname character varying(200) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_mast_sku_class ALTER COLUMN rowid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_mast_sku_class_rowid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);