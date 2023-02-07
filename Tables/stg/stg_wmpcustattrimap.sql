CREATE TABLE IF NOT EXISTS stg.stg_wmpcustattrimap
(
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    customer_id character varying(40)  NOT NULL,
    customer_name character varying(72) NOT NULL,
    attribute_code character varying(72)  NOT NULL,
    attribute_name character varying(72)  NOT NULL,
    attribute_prcnt numeric(20,2),
    etlcreateddatetime timestamp(3) without time zone,
    CONSTRAINT wmpcustattrimap_pk PRIMARY KEY (customer_id, attribute_code)
)
