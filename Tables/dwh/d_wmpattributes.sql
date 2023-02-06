

CREATE TABLE IF NOT EXISTS dwh.d_wmpattributes
(
    attributes_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
    category_code character varying(72) NOT NULL,
    subcategory_code character varying(72)  NOT NULL,
    attribute_code character varying(72)  NOT NULL,
    attribute_name character varying(72)  NOT NULL,
    etlactiveind integer,
    etljobname character varying(200) ,
    envsourcecd character varying(50) ,
    datasourcecd character varying(50) ,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT wmpattributes_pk PRIMARY KEY (attributes_key),
    CONSTRAINT wmpattributes_uk UNIQUE (category_code, attribute_code)
)