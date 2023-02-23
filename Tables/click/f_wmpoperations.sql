-- Table: click.f_wmpoperations

-- DROP TABLE IF EXISTS click.f_wmpoperations;

CREATE TABLE IF NOT EXISTS click.f_wmpoperations
(
    wmpoperations_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ouid integer,
    orderqualifieddate date,
    orderqualifieddatekey bigint,
    divisioncode character varying(20) COLLATE public.nocase,
    locationcode character varying(20) COLLATE public.nocase,
    locationname character varying(510) COLLATE public.nocase,
    locationcity character varying(100) COLLATE public.nocase,
    locationstate character varying(80) COLLATE public.nocase,
    statename character varying(80) COLLATE public.nocase,
    customerid character varying(40) COLLATE public.nocase,
    customername character varying(80) COLLATE public.nocase,
    attributecode character varying(20) COLLATE public.nocase,
    attributeweightpercnt numeric(20,2),
    totalreceivedorders bigint,
    ordcompletedontime bigint,
    ontimecompletedpercnt numeric(20,2),
    slapercnt numeric(20,2),
    totalprocessedorders bigint,
    orderfullfillmentpercnt numeric(20,2),
    CONSTRAINT f_wmpoperations_pkey PRIMARY KEY (wmpoperations_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_wmpoperations
    OWNER to proconnect;