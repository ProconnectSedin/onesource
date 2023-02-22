-- Table: dwh.d_suppspmnsuplmain

-- DROP TABLE IF EXISTS dwh.d_suppspmnsuplmain;

CREATE TABLE IF NOT EXISTS dwh.d_suppspmnsuplmain
(
    suppspmnsuplmain_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    supp_spmn_loid character varying(40) COLLATE public.nocase,
    supp_spmn_supcode character varying(32) COLLATE public.nocase,
    supp_spmn_supname character varying(120) COLLATE public.nocase,
    supp_spmn_supname_shd character varying(120) COLLATE public.nocase,
    supp_spmn_suptype character varying(16) COLLATE public.nocase,
    supp_spmn_suplevel character varying(16) COLLATE public.nocase,
    supp_spmn_classification character varying(16) COLLATE public.nocase,
    supp_spmn_companycode character varying(20) COLLATE public.nocase,
    supp_spmn_customercode character varying(36) COLLATE public.nocase,
    supp_spmn_createdou integer,
    supp_spmn_taxexempt character varying(16) COLLATE public.nocase,
    supp_spmn_createdby character varying(60) COLLATE public.nocase,
    supp_spmn_createdate timestamp without time zone,
    supp_spmn_modifiedby character varying(60) COLLATE public.nocase,
    supp_spmn_modifieddate timestamp without time zone,
    supp_spmn_timestamp integer,
    supp_spmn_cagent character(1) COLLATE pg_catalog."default",
    supp_spmn_carr character(1) COLLATE pg_catalog."default",
    supp_spmn_contst character(1) COLLATE pg_catalog."default",
    supp_spmn_1099app character varying(50) COLLATE public.nocase,
    supp_spmn_nuseries character varying(20) COLLATE public.nocase,
    supp_spmn_appointedfrom timestamp without time zone,
    supp_spmn_approvaldate timestamp without time zone,
    supp_spmn_approved_status character varying(16) COLLATE public.nocase,
    supp_spmn_purpose character varying(16) COLLATE public.nocase,
    supp_spmn_broker_type character varying(16) COLLATE public.nocase,
    supp_spmn_class character varying(16) COLLATE public.nocase,
    supp_spmn_supcategory character varying(200) COLLATE public.nocase,
    supp_spmn_suppdesc character varying(510) COLLATE public.nocase,
    supp_revision_no integer,
    supp_msme_flag character varying(510) COLLATE public.nocase,
    supp_msme_regno character varying(24) COLLATE public.nocase,
    supp_msme_type character varying(16) COLLATE public.nocase,
    supp_msme_regtype character varying(80) COLLATE public.nocase,
    supp_msme_datefrom timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_suppspmnsuplmain_pkey PRIMARY KEY (suppspmnsuplmain_key),
    CONSTRAINT d_suppspmnsuplmain_ukey UNIQUE (supp_spmn_loid, supp_spmn_supcode)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_suppspmnsuplmain
    OWNER to proconnect;
-- Index: d_suppspmnsuplmain_key_idx1

-- DROP INDEX IF EXISTS dwh.d_suppspmnsuplmain_key_idx1;

CREATE INDEX IF NOT EXISTS d_suppspmnsuplmain_key_idx1
    ON dwh.d_suppspmnsuplmain USING btree
    (supp_spmn_loid COLLATE public.nocase ASC NULLS LAST, supp_spmn_supcode COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;