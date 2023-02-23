-- Table: stg.stg_supp_bu_suplmain

-- DROP TABLE IF EXISTS stg.stg_supp_bu_suplmain;

CREATE TABLE IF NOT EXISTS stg.stg_supp_bu_suplmain
(
    supp_bu_loid character varying(80) COLLATE public.nocase NOT NULL,
    supp_bu_buid character varying(80) COLLATE public.nocase NOT NULL,
    supp_bu_supcode character varying(64) COLLATE public.nocase NOT NULL,
    supp_bu_currency character(20) COLLATE public.nocase NOT NULL,
    supp_bu_language character varying(100) COLLATE public.nocase NOT NULL,
    supp_bu_deforderto character varying(24) COLLATE public.nocase,
    supp_bu_defshipfrom character varying(24) COLLATE public.nocase,
    supp_bu_defpayto character varying(24) COLLATE public.nocase,
    supp_bu_incoterm character varying(48) COLLATE public.nocase,
    supp_bu_incoplace character varying(64) COLLATE public.nocase,
    supp_bu_payterm character varying(60) COLLATE public.nocase,
    supp_bu_advpayable character varying(32) COLLATE public.nocase,
    supp_bu_advtolerance integer,
    supp_bu_autoinvoice character varying(32) COLLATE public.nocase,
    supp_bu_ddchargeborneby character varying(32) COLLATE public.nocase,
    supp_bu_pregrinvoice character varying(32) COLLATE public.nocase,
    supp_bu_supinvmand character varying(32) COLLATE public.nocase,
    supp_bu_matlreconcby character varying(32) COLLATE public.nocase,
    supp_bu_idagency character varying(80) COLLATE public.nocase,
    supp_bu_idno character varying(72) COLLATE public.nocase,
    supp_bu_contcdliablity character varying(32) COLLATE public.nocase,
    supp_bu_invoiceou integer,
    supp_bu_insliability character varying(32) COLLATE public.nocase,
    supp_bu_insuranceterm character varying(60) COLLATE public.nocase,
    supp_bu_inheritou integer,
    supp_bu_createdby character varying(120) COLLATE public.nocase NOT NULL,
    supp_bu_createdate timestamp without time zone NOT NULL,
    supp_bu_modifiedby character varying(120) COLLATE public.nocase NOT NULL,
    supp_bu_modifieddate timestamp without time zone NOT NULL,
    supp_bu_groption character varying(1024) COLLATE public.nocase NOT NULL,
    supp_bu_allowinv character varying(100) COLLATE public.nocase,
    supp_bu_refdby character varying(32) COLLATE public.nocase,
    supp_bu_refdby_code character varying(64) COLLATE public.nocase,
    supp_bu_refdby_name character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_supp_bu_suplmain
    OWNER to proconnect;