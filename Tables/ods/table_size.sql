CREATE TABLE ods.table_size (
    rowid bigint NOT NULL,
    snapshot_date timestamp without time zone,
    db_name character varying,
    table_schema character varying,
    table_name character varying,
    row_count bigint,
    table_size character varying
);

ALTER TABLE ods.table_size ALTER COLUMN rowid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ods.table_size_rowid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);