-- Table: click.f_wmpscoreboard

-- DROP TABLE IF EXISTS click.f_wmpscoreboard;

CREATE TABLE IF NOT EXISTS click.f_wmpscoreboard
(
    wmpsbkey bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ouid integer,
    datekey bigint,
    lockey bigint,
    customerkey bigint,
    orderqualifieddate date,
    divisioncode character varying(20) COLLATE public.nocase,
    locationcode character varying(20) COLLATE public.nocase,
    locationname character varying(100) COLLATE public.nocase,
    locationcity character varying(100) COLLATE public.nocase,
    locationstate character varying(100) COLLATE public.nocase,
    statename character varying(100) COLLATE public.nocase,
    region character varying(100) COLLATE public.nocase,
    customerid character varying(40) COLLATE public.nocase,
    customername character varying(100) COLLATE public.nocase,
    slaactual numeric(20,2),
    slatarget numeric(20,2),
    slascore numeric(20,2),
    orfactual numeric(20,2),
    orftarget numeric(20,2),
    orfscore numeric(20,2),
    dccactual numeric(20,2),
    dcctarget numeric(20,2),
    dccscore numeric(20,2),
    dcpscore numeric(20,2),
    inventoryaccuracy numeric(20,2),
    inventoryaccuracytarget numeric(20,2),
    inventoryaccuracyscore numeric(20,2),
    customerclaimscore numeric(20,2),
    absenteeismactual numeric(20,2),
    absenteeismtarget numeric(20,2),
    absenteeismscore numeric(20,2),
    attritionactual numeric(20,2),
    attritiontarget numeric(20,2),
    attritionscore numeric(20,2),
    accidentfreedayscore numeric(20,2),
    securitygadgetsscore numeric(20,2),
    npsscore numeric(20,2),
    totalopearationscore numeric(20,2),
    CONSTRAINT f_wmpscoreboard_pkey PRIMARY KEY (wmpsbkey)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_wmpscoreboard
    OWNER to proconnect;