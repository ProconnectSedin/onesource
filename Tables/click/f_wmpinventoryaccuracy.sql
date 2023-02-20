-- Table: click.f_wmpinventoryaccuracy

-- DROP TABLE IF EXISTS click.f_wmpinventoryaccuracy;

CREATE TABLE IF NOT EXISTS click.f_wmpinventoryaccuracy
(
    wmpinventoryaccuracy_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ouid integer,
    stockcountdate date,
    divisioncode character varying(20) COLLATE pg_catalog."default",
    locationcode character varying(20) COLLATE pg_catalog."default",
    customerid character varying(40) COLLATE pg_catalog."default",
    itemcode character varying(20) COLLATE pg_catalog."default",
    totalexpected bigint,
    totalavailable bigint,
    variance bigint,
    variancepercnt numeric(20,2),
    inventoryaccuracy numeric(20,2),
    CONSTRAINT f_wmpinventoryaccuracy_pkey PRIMARY KEY (wmpinventoryaccuracy_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_wmpinventoryaccuracy
    OWNER to proconnect;