-- Table: raw.raw_supp_ou_suplmain

-- DROP TABLE IF EXISTS "raw".raw_supp_ou_suplmain;

CREATE TABLE IF NOT EXISTS "raw".raw_supp_ou_suplmain
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_supp_ou_suplmain_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_supp_ou_suplmain
    OWNER to proconnect;