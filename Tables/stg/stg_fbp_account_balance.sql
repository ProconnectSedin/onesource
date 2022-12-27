CREATE TABLE stg.stg_fbp_account_balance (
    ou_id integer NOT NULL,
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    fb_id character varying(80) NOT NULL COLLATE public.nocase,
    fin_year character varying(60) NOT NULL COLLATE public.nocase,
    fin_period character varying(60) NOT NULL COLLATE public.nocase,
    account_code character varying(128) NOT NULL COLLATE public.nocase,
    currency_code character varying(20) NOT NULL COLLATE public.nocase,
    "timestamp" integer,
    ob_credit numeric,
    ob_debit numeric,
    period_credit numeric,
    period_debit numeric,
    cb_credit numeric,
    cb_debit numeric,
    recon_status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    ari_upd_flag character varying(48) DEFAULT 'N'::character varying COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_fbp_account_balance
    ADD CONSTRAINT fbp_account_balance_pkey PRIMARY KEY (ou_id, company_code, fb_id, fin_year, fin_period, account_code, currency_code);