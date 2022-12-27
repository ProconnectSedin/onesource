CREATE TABLE dwh.f_abbaccountbudgetdtl (
    f_abbaccountbudgetdtl_key bigint NOT NULL,
    company_code character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    fin_year_code character varying(20) COLLATE public.nocase,
    fin_period_code character varying(20) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    "timestamp" integer,
    control_action character varying(40) COLLATE public.nocase,
    budget_amount numeric(13,2),
    carry_fwd_budget character varying(50) COLLATE public.nocase,
    app_season_pat character varying(50) COLLATE public.nocase,
    status character varying(50) COLLATE public.nocase,
    account_currency character varying(10) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    basecur_erate numeric(13,2),
    budamt_base numeric(13,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);