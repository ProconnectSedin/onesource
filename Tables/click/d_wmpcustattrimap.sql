
-- DROP TABLE IF EXISTS click.d_wmpcustattrimap;

CREATE TABLE IF NOT EXISTS click.d_wmpcustattrimap
(
    custattrimap_key bigint NOT NULL,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    customer_id character varying(40) COLLATE public.nocase,
    customer_name character varying(72) COLLATE public.nocase NOT NULL,
    attribute_code character varying(72) COLLATE public.nocase NOT NULL,
    attribute_name character varying(72) COLLATE public.nocase NOT NULL,
    attribute_prcnt numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    createddate timestamp(3) without time zone,
    updatedatetime timestamp(3) without time zone,
    CONSTRAINT wmpcustattrimap_pk PRIMARY KEY (custattrimap_key),
    CONSTRAINT wmpcustattrimap_uk UNIQUE (customer_id, attribute_code)
)
