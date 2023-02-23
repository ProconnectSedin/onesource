-- Table: dwh.d_suppbusuplmain

-- DROP TABLE IF EXISTS dwh.d_suppbusuplmain;

CREATE TABLE IF NOT EXISTS dwh.d_suppbusuplmain
(
    suppbusuplmain_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    supp_bu_loid character varying(40) COLLATE public.nocase,
    supp_bu_buid character varying(40) COLLATE public.nocase,
    supp_bu_supcode character varying(32) COLLATE public.nocase,
    supp_bu_currency character varying(32) COLLATE pg_catalog."default",
    supp_bu_language character varying(50) COLLATE public.nocase,
    supp_bu_deforderto character varying(12) COLLATE public.nocase,
    supp_bu_defshipfrom character varying(12) COLLATE public.nocase,
    supp_bu_defpayto character varying(12) COLLATE public.nocase,
    supp_bu_incoterm character varying(24) COLLATE public.nocase,
    supp_bu_payterm character varying(30) COLLATE public.nocase,
    supp_bu_advpayable character varying(16) COLLATE public.nocase,
    supp_bu_advtolerance integer,
    supp_bu_autoinvoice character varying(16) COLLATE public.nocase,
    supp_bu_ddchargeborneby character varying(16) COLLATE public.nocase,
    supp_bu_pregrinvoice character varying(16) COLLATE public.nocase,
    supp_bu_supinvmand character varying(16) COLLATE public.nocase,
    supp_bu_matlreconcby character varying(16) COLLATE public.nocase,
    supp_bu_contcdliablity character varying(16) COLLATE public.nocase,
    supp_bu_invoiceou integer,
    supp_bu_insliability character varying(16) COLLATE public.nocase,
    supp_bu_createdby character varying(60) COLLATE public.nocase,
    supp_bu_createdate timestamp without time zone,
    supp_bu_modifiedby character varying(60) COLLATE public.nocase,
    supp_bu_modifieddate timestamp without time zone,
    supp_bu_groption character varying(512) COLLATE public.nocase,
    supp_bu_allowinv character varying(50) COLLATE public.nocase,
    supp_bu_refdby character varying(16) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_suppbusuplmain_pkey PRIMARY KEY (suppbusuplmain_key),
    CONSTRAINT d_suppbusuplmain_ukey UNIQUE (supp_bu_loid, supp_bu_buid, supp_bu_supcode)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_suppbusuplmain
    OWNER to proconnect;