CREATE TABLE dwh.f_fbpaccountbalance (
    fbp_act_blc_key bigint NOT NULL,
    fbp_act_curr_key bigint NOT NULL,
    ou_id integer,
    company_code character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    fin_year character varying(30) COLLATE public.nocase,
    fin_period character varying(30) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    "timestamp" integer,
    ob_credit numeric(20,2),
    ob_debit numeric(20,2),
    period_credit numeric(20,2),
    period_debit numeric(20,2),
    cb_credit numeric(20,2),
    cb_debit numeric(20,2),
    recon_status character varying(50) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    ari_upd_flag character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_fbpaccountbalance ALTER COLUMN fbp_act_blc_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_fbpaccountbalance_fbp_act_blc_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_fbpaccountbalance
    ADD CONSTRAINT f_fbpaccountbalance_pkey PRIMARY KEY (fbp_act_blc_key);

ALTER TABLE ONLY dwh.f_fbpaccountbalance
    ADD CONSTRAINT f_fbpaccountbalance_ukey UNIQUE (ou_id, company_code, fb_id, fin_year, fin_period, account_code, currency_code);

ALTER TABLE ONLY dwh.f_fbpaccountbalance
    ADD CONSTRAINT f_fbpaccountbalance_fbp_act_curr_key_fkey FOREIGN KEY (fbp_act_curr_key) REFERENCES dwh.d_currency(curr_key);

CREATE INDEX f_fbpaccountbalance_key_idx ON dwh.f_fbpaccountbalance USING btree (fbp_act_curr_key);