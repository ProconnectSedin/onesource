CREATE TABLE IF NOT EXISTS stg.stg_wmpattributes
(
    category_code character varying(72) COLLATE public.nocase NOT NULL,
    subcategory_code character varying(72) COLLATE public.nocase NOT NULL,
    attribute_code character varying(72) COLLATE public.nocase NOT NULL,
    attribute_name character varying(72) COLLATE public.nocase NOT NULL,
    etlcreateddatetime timestamp(3) without time zone,
    CONSTRAINT wmpattributes_pk PRIMARY KEY (category_code, attribute_code)
)