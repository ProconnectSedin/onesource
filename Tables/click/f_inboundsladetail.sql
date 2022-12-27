CREATE TABLE click.f_inboundsladetail (
    sla_ib_key bigint NOT NULL,
    sla_ouid integer,
    sla_lockey bigint,
    sla_customerkey bigint,
    sla_datekey bigint,
    sla_customerid character varying(40) COLLATE public.nocase,
    sla_loccode character varying(20) COLLATE public.nocase,
    sla_dateactual date,
    sla_prefdocno character varying(80) COLLATE public.nocase,
    sla_supasnno character varying(80) COLLATE public.nocase,
    sla_ordtime time without time zone,
    sla_cutofftime time without time zone,
    sla_asntype character varying(20) COLLATE public.nocase,
    sla_preftype character varying(20) COLLATE public.nocase,
    sla_grnstatus character varying(20) COLLATE public.nocase,
    sla_pwaystatus character varying(20) COLLATE public.nocase,
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
    sla_loadeddatetime timestamp without time zone DEFAULT CURRENT_DATE
);

ALTER TABLE click.f_inboundsladetail ALTER COLUMN sla_ib_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_inboundsladetail_sla_ib_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_inboundsladetail
    ADD CONSTRAINT f_inboundsladetail_pk PRIMARY KEY (sla_ib_key);

CREATE INDEX f_inboundsladetail_ndx ON click.f_inboundsladetail USING btree (sla_ouid, sla_customerkey, sla_datekey, sla_lockey, sla_prefdocno);