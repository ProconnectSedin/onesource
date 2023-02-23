-- Table: click.f_wmpcyclecount

-- DROP TABLE IF EXISTS click.f_wmpcyclecount;

CREATE TABLE IF NOT EXISTS click.f_wmpcyclecount
(
    wmpcyclecount_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ouid integer,
    cyclecountdate date,
    divisioncode character varying(20) COLLATE public.nocase,
    locationcode character varying(20) COLLATE public.nocase,
    locationname character varying(510) COLLATE public.nocase,
    locationcity character varying(100) COLLATE public.nocase,
    locationstate character varying(80) COLLATE public.nocase,
    statename character varying(80) COLLATE public.nocase,
    customerid character varying(40) COLLATE public.nocase,
    customername character varying(80) COLLATE public.nocase,
    itemcyclecount bigint,
    minitemcyclecount bigint DEFAULT 1,
    avgvariancepercnt numeric(20,2),
    dccaccuracypercnt numeric(20,2),
    CONSTRAINT f_wmpcyclecount_pkey PRIMARY KEY (wmpcyclecount_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_wmpcyclecount
    OWNER to proconnect;