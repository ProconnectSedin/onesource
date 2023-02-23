-- Table: stg.stg_supp_ou_suplmain

-- DROP TABLE IF EXISTS stg.stg_supp_ou_suplmain;

CREATE TABLE IF NOT EXISTS stg.stg_supp_ou_suplmain
(
    supp_ou_loid character varying(80) COLLATE public.nocase NOT NULL,
    supp_ou_ouinstid integer NOT NULL,
    supp_ou_supcode character varying(64) COLLATE public.nocase NOT NULL,
    supp_ou_supstatus character(8) COLLATE public.nocase NOT NULL,
    supp_ou_paymentpriority character varying(32) COLLATE public.nocase,
    supp_ou_approved character varying(32) COLLATE public.nocase,
    supp_ou_approveddate timestamp without time zone,
    supp_ou_reasoncode character varying(40) COLLATE public.nocase,
    supp_ou_createdby character varying(120) COLLATE public.nocase NOT NULL,
    supp_ou_createdate timestamp without time zone NOT NULL,
    supp_ou_modifiedby character varying(120) COLLATE public.nocase NOT NULL,
    supp_ou_modifieddate timestamp without time zone NOT NULL,
    supp_ou_bucode character varying(80) COLLATE public.nocase,
    supp_ou_companycode character varying(40) COLLATE public.nocase,
    supp_ou_licenseno character varying(160) COLLATE public.nocase,
    supp_ou_gen_from character varying(1020) COLLATE public.nocase,
    supp_pan_number character varying(200) COLLATE public.nocase,
    supp_wf_status character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_supp_ou_suplmain
    OWNER to proconnect;