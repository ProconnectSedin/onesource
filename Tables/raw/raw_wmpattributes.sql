CREATE TABLE IF NOT EXISTS "raw".raw_wmpattributes
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    category_code character varying(72) COLLATE public.nocase NOT NULL,
    subcategory_code character varying(72) COLLATE public.nocase NOT NULL,
    attribute_code character varying(72) COLLATE public.nocase NOT NULL,
    attribute_name character varying(72) COLLATE public.nocase NOT NULL,
    etlcreateddatetime timestamp(3) without time zone,
    CONSTRAINT raw_wmpattributes_pkey PRIMARY KEY (raw_id)
)