CREATE TABLE ods.table_size_clickhouse (
    snapshot_date timestamp without time zone,
    "parts.database" text,
    "parts.table" text,
    rows bigint,
    latest_modification timestamp without time zone,
    compressed_size text,
    uncompressed_size text
);