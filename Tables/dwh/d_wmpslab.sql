CREATE TABLE IF NOT EXISTS dwh.d_wmpslab
(
    wmpslab_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    category character varying(40),
    subcategory character varying(40) ,
    slab_prcnt_from numeric(20,2),
    slab_prcnt_to numeric(20,2),
    score numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) ,
    envsourcecd character varying(50) ,
    datasourcecd character varying(50) ,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT wmpslab_pk PRIMARY KEY (wmpslab_key)
)