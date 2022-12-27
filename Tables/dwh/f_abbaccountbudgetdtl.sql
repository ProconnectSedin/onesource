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

ALTER TABLE dwh.f_abbaccountbudgetdtl ALTER COLUMN f_abbaccountbudgetdtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_abbaccountbudgetdtl_f_abbaccountbudgetdtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_abbaccountbudgetdtl
    ADD CONSTRAINT f_abbaccountbudgetdtl_pkey PRIMARY KEY (f_abbaccountbudgetdtl_key);

ALTER TABLE ONLY dwh.f_abbaccountbudgetdtl
    ADD CONSTRAINT f_abbaccountbudgetdtl_ukey UNIQUE (company_code, fb_id, fin_year_code, fin_period_code, account_code);

CREATE INDEX f_abbaccountbudgetdtl_key_idx ON dwh.f_abbaccountbudgetdtl USING btree (company_code, fb_id, fin_year_code, fin_period_code, account_code);