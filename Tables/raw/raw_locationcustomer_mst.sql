-- Table: raw.raw_locationcustomer_mst

-- DROP TABLE IF EXISTS "raw".raw_locationcustomer_mst;

CREATE TABLE IF NOT EXISTS "raw".raw_locationcustomer_mst
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tranou integer,
    tranouname character varying(10) COLLATE pg_catalog."default",
    customercode character varying(50) COLLATE pg_catalog."default",
    customername character varying(500) COLLATE pg_catalog."default",
    locationcode character varying(10) COLLATE pg_catalog."default",
    locationname character varying(500) COLLATE pg_catalog."default",
    fbid character varying(20) COLLATE pg_catalog."default",
    costcenter character varying(50) COLLATE pg_catalog."default",
    operationregionid integer,
    operationregion character varying(10) COLLATE pg_catalog."default",
    salesregionid integer,
    salesregion character varying(10) COLLATE pg_catalog."default",
    actualcostcenter character varying(50) COLLATE pg_catalog."default",
    businesstypeid integer,
    businesstype character varying(500) COLLATE pg_catalog."default",
    vertical character varying(200) COLLATE pg_catalog."default",
    spacesqft numeric(25,2),
    warehouseclass character varying(10) COLLATE pg_catalog."default",
    locationcity character varying(500) COLLATE pg_catalog."default",
    citytype character varying(500) COLLATE pg_catalog."default",
    customer_creation_date timestamp without time zone,
    customertype character varying(100) COLLATE pg_catalog."default",
    customergroup character varying(100) COLLATE pg_catalog."default",
    customerbusinesstype character varying(100) COLLATE pg_catalog."default",
    billingtype character varying(500) COLLATE pg_catalog."default",
    customer_creation_month character varying(30) COLLATE pg_catalog."default",
    customer_creation_year character varying(50) COLLATE pg_catalog."default",
    storagearea numeric(25,2),
    customer_name_group character varying(50) COLLATE pg_catalog."default",
    businesstype1 character varying(100) COLLATE pg_catalog."default",
    sam1 character(25) COLLATE pg_catalog."default",
    location_status character varying(50) COLLATE pg_catalog."default",
    warehouse_type character varying(50) COLLATE pg_catalog."default",
    locust_code character varying(20) COLLATE pg_catalog."default",
    access character varying(50) COLLATE pg_catalog."default",
    locationtype character varying(40) COLLATE pg_catalog."default",
    wh_group character varying(50) COLLATE pg_catalog."default",
    master_created_by character varying(50) COLLATE pg_catalog."default",
    etlcreatedatetime timestamp(3) without time zone,
    CONSTRAINT raw_locationcustomer_mst_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_locationcustomer_mst
    OWNER to proconnect;