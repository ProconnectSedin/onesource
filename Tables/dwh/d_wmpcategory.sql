CREATE TABLE IF NOT EXISTS dwh.d_wmpcategory
(
    category_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
    category_code character varying(72)  NOT NULL,
    category_desc character varying(72) NOT NULL,
    subcategory_code character varying(72)  NOT NULL,
    subcategory_desc character varying(72)  NOT NULL,
    target_prcnt numeric(20,2),
    final_weightage_prcnt numeric(20,2),
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) ,
    envsourcecd character varying(50) ,
    datasourcecd character varying(50),
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT wmpcategory_pk PRIMARY KEY (category_key),
    CONSTRAINT wmpcategory_uk UNIQUE (category_code, subcategory_code)
)