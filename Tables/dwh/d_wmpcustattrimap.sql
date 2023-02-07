CREATE TABLE IF NOT EXISTS dwh.d_wmpcustattrimap
(
    custattrimap_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    customer_id character varying(40) COLLATE public.nocase,
    customer_name character varying(72) NOT NULL,
    attribute_code character varying(72)  NOT NULL,
    attribute_name character varying(72)  NOT NULL,
    attribute_prcnt numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) ,
    envsourcecd character varying(50) ,
    datasourcecd character varying(50),
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT wmpcustattrimap_pk PRIMARY KEY (custattrimap_key),
    CONSTRAINT wmpcustattrimap_uk UNIQUE (customer_id, attribute_code)
)