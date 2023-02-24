-- Table: stg.stg_fbp_ibe_trn_dtl

-- DROP TABLE IF EXISTS stg.stg_fbp_ibe_trn_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_fbp_ibe_trn_dtl
(
    ou_id integer NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    fin_year character varying(40) COLLATE public.nocase NOT NULL,
    fin_period character varying(40) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    currency_code character varying(20) COLLATE public.nocase NOT NULL,
    "timestamp" integer,
    drcr_flag character varying(24) COLLATE public.nocase,
    base_amount numeric,
    tran_amount numeric,
    batch_id character varying(512) COLLATE public.nocase,
    document_no character varying(72) COLLATE public.nocase,
    tran_type character varying(160) COLLATE public.nocase,
    tran_ou integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    par_base_amount numeric,
    company_code character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT fbp_ibe_trn_dtl_pkey PRIMARY KEY (ou_id, fb_id, fin_year, fin_period, account_code, currency_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_fbp_ibe_trn_dtl
    OWNER to proconnect;
	
CREATE INDEX IF NOT EXISTS stg_fbp_ibe_trn_dtl_idx
    ON stg.stg_fbp_ibe_trn_dtl USING btree
	(ou_id, fb_id, fin_year, fin_period, account_code, currency_code);
	
CREATE INDEX IF NOT EXISTS stg_fbp_ibe_trn_dtl_idx
    ON stg.stg_fbp_ibe_trn_dtl USING btree
	(account_code);
	
CREATE INDEX IF NOT EXISTS stg_fbp_ibe_trn_dtl_idx
    ON stg.stg_fbp_ibe_trn_dtl USING btree
	(currency_code, timestamp);
	
CREATE INDEX IF NOT EXISTS stg_fbp_ibe_trn_dtl_idx
    ON stg.stg_fbp_ibe_trn_dtl USING btree
	(company_code, timestamp);
