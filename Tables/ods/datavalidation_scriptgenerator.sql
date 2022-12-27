-- Table: ods.datavalidation_scriptgenerator

 DROP TABLE IF EXISTS ods.datavalidation_scriptgenerator;

CREATE TABLE IF NOT EXISTS ods.datavalidation_scriptgenerator
(
    row_id bigint NOT NULL,
    db character varying(100) COLLATE public.nocase,
    schemaname character varying(100) COLLATE public.nocase,
    sourcetable character varying(100) COLLATE public.nocase,
    tablename character varying(100) COLLATE public.nocase,
    column_list text COLLATE public.nocase,
    join_tablename text COLLATE public.nocase,
    join_columnname text COLLATE public.nocase,
    whereclause_columnname text COLLATE public.nocase,
    groupby_columnname text COLLATE public.nocase,
    CONSTRAINT datavalidation_scriptgenerator_pkey PRIMARY KEY (row_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS ods.datavalidation_scriptgenerator
    OWNER to proconnect;