
-- DROP TABLE IF EXISTS click.d_wmpattributes;

CREATE TABLE IF NOT EXISTS click.d_wmpattributes
(
    attributes_key bigint NOT NULL,
    category_code character varying(72) COLLATE public.nocase NOT NULL,
    subcategory_code character varying(72) COLLATE public.nocase NOT NULL,
    attribute_code character varying(72) COLLATE public.nocase NOT NULL,
    attribute_name character varying(72) COLLATE public.nocase NOT NULL,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    createddate timestamp(3) without time zone,
    updatedatetime timestamp(3) without time zone,
    CONSTRAINT wmpattributes_pk PRIMARY KEY (attributes_key),
    CONSTRAINT wmpattributes_uk UNIQUE (category_code, attribute_code)
)
