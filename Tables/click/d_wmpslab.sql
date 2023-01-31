
-- DROP TABLE IF EXISTS click.d_wmpslab;

CREATE TABLE IF NOT EXISTS click.d_wmpslab
(
    wmpslab_key bigint NOT NULL,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    category character varying(40) COLLATE pg_catalog."default",
    subcategory character varying(40) COLLATE pg_catalog."default",
    slab_prcnt_from numeric(20,2),
    slab_prcnt_to numeric(20,2),
    score numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE pg_catalog."default",
    envsourcecd character varying(50) COLLATE pg_catalog."default",
    datasourcecd character varying(50) COLLATE pg_catalog."default",
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    createddate timestamp(3) without time zone,
    updatedatetime timestamp(3) without time zone,
    CONSTRAINT wmpslab_pk PRIMARY KEY (wmpslab_key)
)
