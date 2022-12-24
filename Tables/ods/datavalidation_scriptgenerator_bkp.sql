CREATE TABLE ods.datavalidation_scriptgenerator_bkp (
    row_id bigint,
    db character varying(100) COLLATE public.nocase,
    schemaname character varying(100) COLLATE public.nocase,
    tablename character varying(100) COLLATE public.nocase,
    column_list text COLLATE public.nocase,
    join_tablename text COLLATE public.nocase,
    join_columnname text COLLATE public.nocase,
    whereclause_columnname text COLLATE public.nocase,
    groupby_columnname text COLLATE public.nocase
);