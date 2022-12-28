CREATE TABLE click.f_outboundsladetail (
    sla_ob_key bigint NOT NULL,
    sla_ordkey bigint NOT NULL,
    sla_lockey bigint NOT NULL,
    sla_ou integer,
    sla_loccode character varying(20) COLLATE public.nocase,
    sla_ordertype character varying(20) COLLATE public.nocase,
    sla_shipmenttype character varying(20) COLLATE public.nocase,
    sla_sono character varying(20) COLLATE public.nocase,
    sla_orderdate date,
    sla_ordtime time without time zone,
    sla_cutofftime time without time zone,
    sla_pickexecdt timestamp without time zone,
    sla_packexecdt timestamp without time zone,
    sla_pickexpdt timestamp without time zone,
    sla_pickontimeflag integer,
    sla_packexpdt timestamp without time zone,
    sla_packontimeflag integer,
    sla_category character varying(20) COLLATE public.nocase,
    sla_processexpdt timestamp without time zone,
    sla_procontimeflag integer,
    sla_loadeddatetime timestamp without time zone DEFAULT CURRENT_DATE
);

ALTER TABLE click.f_outboundsladetail ALTER COLUMN sla_ob_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_outboundsladetail_sla_ob_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_outboundsladetail
    ADD CONSTRAINT f_outboundsladetail_pk PRIMARY KEY (sla_ob_key);

CREATE INDEX f_outboundsladetail_ndx ON click.f_outboundsladetail USING btree (sla_ordkey);

CREATE INDEX f_outboundsladetail_ndx1 ON click.f_outboundsladetail USING btree (sla_ou, sla_loccode, sla_ordertype, sla_shipmenttype);

CREATE INDEX f_outboundsladetail_ndx2 ON click.f_outboundsladetail USING btree (sla_ou, sla_loccode, sla_sono);