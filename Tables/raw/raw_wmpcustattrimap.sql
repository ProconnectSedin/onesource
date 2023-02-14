CREATE TABLE IF NOT EXISTS "raw".raw_wmpcustattrimap
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    customer_id character varying(40),
    customer_name character varying(72)  NOT NULL,
    attribute_name character varying(72)  NOT NULL,
    attribute_prcnt numeric(20,2),
    etlcreateddatetime timestamp(3) without time zone,
    CONSTRAINT wmpcustattrimap_pkey PRIMARY KEY (raw_id)
)
