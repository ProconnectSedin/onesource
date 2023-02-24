-- Table: raw.raw_rp_checkseries_dtl

-- DROP TABLE IF EXISTS "raw".raw_rp_checkseries_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_rp_checkseries_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    bank_code character varying(128) COLLATE public.nocase NOT NULL,
    checkseries_no character varying(128) COLLATE public.nocase NOT NULL,
    check_no character varying(120) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    sequence_no integer,
    check_date timestamp without time zone,
    check_amount numeric,
    reason_code character varying(40) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    pay_charges numeric,
    instr_no character varying(120) COLLATE public.nocase,
    instr_date timestamp without time zone,
    checkno_status character varying(16) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    bank_acc_no character varying(80) COLLATE public.nocase,
    company_code character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_rp_checkseries_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_rp_checkseries_dtl
    OWNER to proconnect;