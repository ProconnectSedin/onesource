-- Table: raw.raw_supp_spmn_suplmain

-- DROP TABLE IF EXISTS "raw".raw_supp_spmn_suplmain;

CREATE TABLE IF NOT EXISTS "raw".raw_supp_spmn_suplmain
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    supp_spmn_loid character varying(80) COLLATE public.nocase NOT NULL,
    supp_spmn_supcode character varying(64) COLLATE public.nocase NOT NULL,
    supp_spmn_supname character varying(240) COLLATE public.nocase NOT NULL,
    supp_spmn_supname_shd character varying(240) COLLATE public.nocase,
    supp_spmn_suptype character varying(32) COLLATE public.nocase,
    supp_spmn_suplevel character varying(32) COLLATE public.nocase,
    supp_spmn_classification character varying(32) COLLATE public.nocase,
    supp_spmn_companycode character varying(40) COLLATE public.nocase,
    supp_spmn_bucode character varying(80) COLLATE public.nocase,
    supp_spmn_parentsupcode character varying(64) COLLATE public.nocase,
    supp_spmn_customercode character varying(72) COLLATE public.nocase,
    supp_spmn_createdou integer,
    supp_spmn_taxexempt character varying(32) COLLATE public.nocase,
    supp_spmn_certificateno character varying(72) COLLATE public.nocase,
    supp_spmn_createdby character varying(120) COLLATE public.nocase NOT NULL,
    supp_spmn_createdate timestamp without time zone NOT NULL,
    supp_spmn_modifiedby character varying(120) COLLATE public.nocase NOT NULL,
    supp_spmn_modifieddate timestamp without time zone NOT NULL,
    supp_spmn_timestamp integer NOT NULL,
    supp_spmn_qs_cer character varying(80) COLLATE public.nocase,
    supp_spmn_sei_cer character varying(80) COLLATE public.nocase,
    supp_spmn_iso_cer character varying(80) COLLATE public.nocase,
    supp_spmn_iecode character varying(80) COLLATE public.nocase,
    supp_spmn_rbicode character varying(80) COLLATE public.nocase,
    supp_spmn_impreg character varying(80) COLLATE public.nocase,
    supp_spmn_expreg character varying(80) COLLATE public.nocase,
    supp_spmn_cagent character(4) COLLATE public.nocase,
    supp_spmn_carr character(4) COLLATE public.nocase,
    supp_spmn_contst character(4) COLLATE public.nocase,
    supp_spmn_1099app character varying(100) COLLATE public.nocase,
    supp_spmn_ssn character varying(48) COLLATE public.nocase,
    supp_spmn_fein character varying(48) COLLATE public.nocase,
    supp_spmn_nuseries character varying(40) COLLATE public.nocase,
    supp_spmn_appointedfrom timestamp without time zone,
    supp_spmn_appointedto timestamp without time zone,
    supp_spmn_approvaldate timestamp without time zone,
    supp_spmn_approved_status character varying(32) COLLATE public.nocase,
    supp_spmn_purpose character varying(32) COLLATE public.nocase,
    supp_licenseno character varying(160) COLLATE public.nocase,
    supp_spmn_broker_type character varying(32) COLLATE public.nocase,
    supp_spmn_class character varying(32) COLLATE public.nocase NOT NULL DEFAULT 'EX'::character varying,
    supp_spmn_supcategory character varying(400) COLLATE public.nocase,
    supp_spmn_typ1099 character varying(40) COLLATE public.nocase,
    supp_spmn_suppdesc character varying(1020) COLLATE public.nocase,
    supp_revision_no integer NOT NULL DEFAULT 0,
    supp_msme_flag character varying(1020) COLLATE public.nocase,
    supp_msme_regno character varying(48) COLLATE public.nocase,
    supp_msme_type character varying(32) COLLATE public.nocase,
    supp_msme_regtype character varying(160) COLLATE public.nocase,
    supp_msme_datefrom timestamp without time zone,
    supp_msme_dateto timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_supp_spmn_suplmain_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_supp_spmn_suplmain
    OWNER to proconnect;