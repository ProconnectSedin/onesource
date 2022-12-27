-- Table: stg.stg_datavalidation

DROP TABLE IF EXISTS stg.stg_datavalidation;

CREATE TABLE IF NOT EXISTS stg.stg_datavalidation
(
    sourcetable character varying COLLATE pg_catalog."default",
    dimension character varying COLLATE pg_catalog."default",
    period character varying COLLATE pg_catalog."default",
    sourcedatacount bigint,
    createddate timestamp without time zone,
    etlcreateddate timestamp without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_datavalidation
    OWNER to proconnect;
