-- Table: ods.datavalidation_error

-- DROP TABLE IF EXISTS ods.datavalidation_error;

CREATE TABLE IF NOT EXISTS ods.datavalidation_error
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    spname character varying(50) COLLATE pg_catalog."default",
    type character varying(100) COLLATE pg_catalog."default",
    sourcetable character varying(100) COLLATE pg_catalog."default",
    targettablename character varying(100) COLLATE pg_catalog."default",
    errorline character varying(100) COLLATE pg_catalog."default",
    errorid character varying(100) COLLATE pg_catalog."default",
    errordesc character varying(100) COLLATE pg_catalog."default",
    errordate timestamp(3) without time zone,
    CONSTRAINT datavalidation_error_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS ods.datavalidation_error
    OWNER to proconnect;