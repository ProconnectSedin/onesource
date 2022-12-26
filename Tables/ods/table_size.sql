CREATE TABLE ods.table_size (
    rowid bigint NOT NULL,
    snapshot_date timestamp without time zone,
    db_name character varying,
    table_schema character varying,
    table_name character varying,
    row_count bigint,
    table_size character varying
);