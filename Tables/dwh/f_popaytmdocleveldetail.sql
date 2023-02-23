-- Table: dwh.f_popaytmdocleveldetail

-- DROP TABLE IF EXISTS dwh.f_popaytmdocleveldetail;

CREATE TABLE IF NOT EXISTS dwh.f_popaytmdocleveldetail
(
    paytm_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    paytm_suppkey bigint,
    paytm_poou integer,
    paytm_pono character varying(36) COLLATE public.nocase,
    paytm_poamendmentno integer,
    paytm_advancepayable numeric(13,2),
    paytm_payterm character varying(30) COLLATE public.nocase,
    paytm_paytosupplier character varying(32) COLLATE public.nocase,
    paytm_paymode character varying(50) COLLATE public.nocase,
    paytm_paymentstatus character varying(16) COLLATE public.nocase,
    paytm_advancepaid numeric(13,2),
    paytm_invoiceou integer,
    paytm_insuranceliability character varying(16) COLLATE public.nocase,
    paytm_ddchargesbornby character varying(16) COLLATE public.nocase,
    paytm_insuranceterm character varying(30) COLLATE public.nocase,
    paytm_insuranceamt numeric(13,2),
    paytm_autoinvoice character varying(16) COLLATE public.nocase,
    paytm_incoterm character varying(24) COLLATE public.nocase,
    paytm_addressid character varying(12) COLLATE public.nocase,
    paytm_transhipment character varying(16) COLLATE public.nocase,
    paytm_shippartial character varying(16) COLLATE public.nocase,
    paytm_incoplace character varying(80) COLLATE public.nocase,
    paytm_createdby character varying(60) COLLATE public.nocase,
    paytm_createddate timestamp without time zone,
    paytm_lastmodifiedby character varying(60) COLLATE public.nocase,
    paytm_lastmodifieddate timestamp without time zone,
    paytm_groption character varying(16) COLLATE public.nocase,
    paytm_advancetolerance numeric(13,2),
    paytm_invoicebeforegr character varying(16) COLLATE public.nocase,
    paytm_packingremarks character varying(1020) COLLATE public.nocase,
    paytm_shippingremarks character varying(1020) COLLATE public.nocase,
    lcbg_app character varying(50) COLLATE public.nocase,
    paytm_advancerequired character varying(16) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_popaytmdocleveldetail_pkey PRIMARY KEY (paytm_key),
    CONSTRAINT f_popaytmdocleveldetail_ukey UNIQUE (paytm_poou, paytm_pono, paytm_poamendmentno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_popaytmdocleveldetail
    OWNER to proconnect;
-- Index: f_popaytmdocleveldetail_key_idx

-- DROP INDEX IF EXISTS dwh.f_popaytmdocleveldetail_key_idx;

CREATE INDEX IF NOT EXISTS f_popaytmdocleveldetail_key_idx
    ON dwh.f_popaytmdocleveldetail USING btree
    (paytm_poou ASC NULLS LAST, paytm_pono COLLATE public.nocase ASC NULLS LAST, paytm_poamendmentno ASC NULLS LAST)
    TABLESPACE pg_default;