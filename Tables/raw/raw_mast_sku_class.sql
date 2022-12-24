CREATE TABLE raw.raw_mast_sku_class (
    raw_id bigint NOT NULL,
    rowid integer NOT NULL,
    customercode character varying(50) COLLATE public.nocase,
    materialgroup character varying(50) COLLATE public.nocase,
    sbucode character varying(50) COLLATE public.nocase,
    sbuname character varying(200) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);