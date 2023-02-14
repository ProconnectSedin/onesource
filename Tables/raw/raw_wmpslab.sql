CREATE TABLE IF NOT EXISTS "raw".raw_wmpslab
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    category character varying(40) ,
    subcategory character varying(40),
    slab_prcnt_from numeric(20,2),
    slab_prcnt_to numeric(20,2),
    score numeric(20,2),
    etlcreateddatetime timestamp(3) without time zone,
    CONSTRAINT raw_wmpslab_pkey PRIMARY KEY (raw_id)
)