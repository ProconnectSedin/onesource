CREATE TABLE raw.raw_abb_account_budget_dtl (
    raw_id bigint NOT NULL,
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    fb_id character varying(80) NOT NULL COLLATE public.nocase,
    fin_year_code character varying(40) NOT NULL COLLATE public.nocase,
    fin_period_code character varying(40) NOT NULL COLLATE public.nocase,
    account_code character varying(128) NOT NULL COLLATE public.nocase,
    "timestamp" integer,
    control_action character varying(80) COLLATE public.nocase,
    budget_amount numeric,
    carry_fwd_budget character varying(100) COLLATE public.nocase,
    app_season_pat character varying(100) COLLATE public.nocase,
    status character varying(100) COLLATE public.nocase,
    account_currency character varying(20) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    carry_fwd_amount numeric,
    basecur_erate numeric,
    parbasecur_erate numeric,
    budamt_base numeric,
    budamt_parbase numeric,
    forecastamt numeric,
    forecastamt_base numeric,
    forecastamt_parbase numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_abb_account_budget_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_abb_account_budget_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_abb_account_budget_dtl
    ADD CONSTRAINT raw_abb_account_budget_dtl_pkey PRIMARY KEY (raw_id);