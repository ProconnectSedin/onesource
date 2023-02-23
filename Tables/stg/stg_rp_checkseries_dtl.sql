-- Table: stg.stg_rp_checkseries_dtl

-- DROP TABLE IF EXISTS stg.stg_rp_checkseries_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_rp_checkseries_dtl
(
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
    CONSTRAINT rp_checkseries_dtl_pkey PRIMARY KEY (ou_id, bank_code, checkseries_no, check_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_rp_checkseries_dtl
    OWNER to proconnect;
-- Index: stg_rp_checkseries_dtl_idx

-- DROP INDEX IF EXISTS stg.stg_rp_checkseries_dtl_idx;

CREATE INDEX IF NOT EXISTS stg_rp_checkseries_dtl_idx
    ON stg.stg_rp_checkseries_dtl USING btree
    (ou_id ASC NULLS LAST, bank_code COLLATE public.nocase ASC NULLS LAST, checkseries_no COLLATE public.nocase ASC NULLS LAST, check_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: stg_rp_checkseries_dtl_idx1

-- DROP INDEX IF EXISTS stg.stg_rp_checkseries_dtl_idx1;

CREATE INDEX IF NOT EXISTS stg_rp_checkseries_dtl_idx1
    ON stg.stg_rp_checkseries_dtl USING btree
    (bank_acc_no COLLATE public.nocase ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: stg_rp_checkseries_dtl_idx2

-- DROP INDEX IF EXISTS stg.stg_rp_checkseries_dtl_idx2;

CREATE INDEX IF NOT EXISTS stg_rp_checkseries_dtl_idx2
    ON stg.stg_rp_checkseries_dtl USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;