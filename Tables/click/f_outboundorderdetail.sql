CREATE TABLE click.f_outboundorderdetail (
    ord_key bigint NOT NULL,
    ord_lockey bigint NOT NULL,
    ord_custkey bigint NOT NULL,
    ord_datekey bigint NOT NULL,
    ord_ou integer,
    ord_loccode character varying(20) COLLATE public.nocase,
    ord_custcode character varying(20) COLLATE public.nocase,
    ord_refdoctype character varying(510) COLLATE public.nocase,
    ord_ordertype character varying(80) COLLATE public.nocase,
    ord_obstatus character varying(20) COLLATE public.nocase,
    ord_shipmentmode character varying(80) COLLATE public.nocase,
    ord_orderdate date,
    ord_shipmenttype character varying(510) COLLATE public.nocase,
    ord_subservicetype character varying(510) COLLATE public.nocase,
    ord_state character varying(80) COLLATE public.nocase,
    ord_city character varying(80) COLLATE public.nocase,
    ord_postcode character varying(80) COLLATE public.nocase,
    ord_sono character varying(80) COLLATE public.nocase,
    ord_itmlineno integer,
    ord_ordqty numeric(21,8),
    ord_balqty numeric(21,8),
    ord_issueqty numeric(21,8),
    ord_processqty numeric(21,8),
    ord_itmvolume numeric(21,8),
    ord_itmwgt numeric(21,8),
    ord_wavestatus character varying(20) COLLATE public.nocase,
    ord_waveallocrule character varying(20) COLLATE public.nocase,
    ord_waveqty numeric(21,8),
    ord_loadeddatetime timestamp without time zone DEFAULT CURRENT_DATE
);

ALTER TABLE click.f_outboundorderdetail ALTER COLUMN ord_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_outboundorderdetail_ord_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_outboundorderdetail
    ADD CONSTRAINT f_outboundorderdetail_pkey PRIMARY KEY (ord_key);

CREATE INDEX f_outboundorderdetail_ndx ON click.f_outboundorderdetail USING btree (ord_ou, ord_lockey, ord_sono);

CREATE INDEX f_outboundorderdetail_ndx1 ON click.f_outboundorderdetail USING btree (ord_ou, ord_lockey, ord_sono);

CREATE INDEX f_outboundorderdetail_ndx2 ON click.f_outboundorderdetail USING btree (ord_ou, ord_lockey, ord_ordertype, ord_shipmenttype);