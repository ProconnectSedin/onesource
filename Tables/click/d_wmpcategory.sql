-- Table: click.d_wmpcategory

-- DROP TABLE IF EXISTS click.d_wmpcategory;

CREATE TABLE IF NOT EXISTS click.d_wmpcategory
(
    category_key bigint NOT NULL,
    category_code character varying(72) COLLATE public.nocase NOT NULL,
    category_desc character varying(72) COLLATE public.nocase NOT NULL,
    subcategory_code character varying(72) COLLATE public.nocase NOT NULL,
    subcategory_desc character varying(72) COLLATE public.nocase NOT NULL,
    target_prcnt numeric(20,2),
    final_weightage_prcnt numeric(20,2),
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    createddate timestamp(3) without time zone,
    updatedatetime timestamp(3) without time zone,
    CONSTRAINT wmpcategory_pk PRIMARY KEY (category_key),
    CONSTRAINT wmpcategory_uk UNIQUE (category_code, subcategory_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.d_wmpcategory
    OWNER to proconnect;