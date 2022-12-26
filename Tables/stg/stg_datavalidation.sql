CREATE TABLE stg.stg_datavalidation (
    sourcetable character varying,
    dimension character varying,
    period character varying,
    sourcedatacount bigint,
    createddate timestamp without time zone,
    etlcreateddate timestamp without time zone
);