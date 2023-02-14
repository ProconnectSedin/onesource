CREATE TABLE IF NOT EXISTS "raw".raw_wmpcategory
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
    category_code character varying(72),
    category_desc character varying(72)  NOT NULL,
    subcategory_code character varying(72)  NOT NULL,
    subcategory_desc character varying(72)  NOT NULL,
    target_prcnt numeric(20,2),
    final_weightage_prcnt numeric(20,2),
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone,
    CONSTRAINT raw_wmpcategory_pkey PRIMARY KEY (raw_id)
)