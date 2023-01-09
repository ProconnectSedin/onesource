-- Table: click.f_inboundsladetail

DROP TABLE IF EXISTS click.f_inboundsladetail;

CREATE TABLE IF NOT EXISTS click.f_inboundsladetail
(
    sla_ib_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    sla_ouid integer,
    sla_lockey bigint,
    sla_customerkey bigint,
    sla_datekey bigint,
    sla_customerid character varying(40) COLLATE public.nocase,
    sla_loccode character varying(20) COLLATE public.nocase,
    sla_dateactual timestamp without time zone,
    sla_prefdocno character varying(80) COLLATE public.nocase,
    sla_supasnno character varying(80) COLLATE public.nocase,
    sla_ordtime time without time zone,
    sla_cutofftime time without time zone,
    sla_openingtime time without time zone,
    sla_asntype character varying(20) COLLATE public.nocase,
    sla_preftype character varying(20) COLLATE public.nocase,
    sla_equipmentflag integer,
    sla_grexecdate timestamp without time zone,
    sla_putawayexecdate timestamp without time zone,
    sla_grexpclstime timestamp without time zone,
    sla_grontime integer,
    sla_pwayexpclstime timestamp without time zone,
    sla_pwayontime integer,
    sla_category character varying(20) COLLATE public.nocase,
    sla_prexpclstime timestamp without time zone,
    sla_prontime integer,
    asn_timediff_inmin integer,
    grn_timediff_inmin integer,
    pway_timediff_inmin integer,
    sla_loadeddatetime timestamp without time zone DEFAULT now(),
    activeindicator integer,
    sla_orderaccountdatekey bigint,
    sla_orderaccountdate timestamp without time zone,
    CONSTRAINT f_inboundsladetail_pk PRIMARY KEY (sla_ib_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_inboundsladetail
    OWNER to proconnect;
-- Index: f_inboundsladetail_ndx

-- DROP INDEX IF EXISTS click.f_inboundsladetail_ndx;

CREATE INDEX IF NOT EXISTS f_inboundsladetail_ndx
    ON click.f_inboundsladetail USING btree
    (sla_ouid ASC NULLS LAST, sla_customerkey ASC NULLS LAST, sla_datekey ASC NULLS LAST, sla_lockey ASC NULLS LAST, sla_prefdocno COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;