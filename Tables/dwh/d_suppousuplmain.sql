-- Table: dwh.d_suppousuplmain

-- DROP TABLE IF EXISTS dwh.d_suppousuplmain;

CREATE TABLE IF NOT EXISTS dwh.d_suppousuplmain
(
    suppousuplmain_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    supp_ou_loid character varying(40) COLLATE public.nocase,
    supp_ou_ouinstid integer,
    supp_ou_supcode character varying(32) COLLATE public.nocase,
    supp_ou_supstatus character varying(32) COLLATE pg_catalog."default",
    supp_ou_paymentpriority character varying(16) COLLATE public.nocase,
    supp_ou_approved character varying(16) COLLATE public.nocase,
    supp_ou_approveddate timestamp without time zone,
    supp_ou_reasoncode character varying(20) COLLATE public.nocase,
    supp_ou_createdby character varying(60) COLLATE public.nocase,
    supp_ou_createdate timestamp without time zone,
    supp_ou_modifiedby character varying(60) COLLATE public.nocase,
    supp_ou_modifieddate timestamp without time zone,
    supp_ou_bucode character varying(40) COLLATE public.nocase,
    supp_ou_companycode character varying(20) COLLATE public.nocase,
    supp_pan_number character varying(100) COLLATE public.nocase,
    supp_wf_status character varying(50) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_suppousuplmain_pkey PRIMARY KEY (suppousuplmain_key),
    CONSTRAINT d_suppousuplmain_ukey UNIQUE (supp_ou_loid, supp_ou_ouinstid, supp_ou_supcode)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_suppousuplmain
    OWNER to proconnect;