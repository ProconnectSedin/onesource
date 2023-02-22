-- Table: dwh.d_macaccountingyear

-- DROP TABLE IF EXISTS dwh.d_macaccountingyear;

CREATE TABLE IF NOT EXISTS dwh.d_macaccountingyear
(
    macaccountingyear_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    company_code character varying(20) COLLATE public.nocase,
    ma_acc_yr_no character varying(30) COLLATE public.nocase,
    ma_start_date timestamp without time zone,
    ma_end_date timestamp without time zone,
    ma_status character varying(10) COLLATE public.nocase,
    ma_user_id integer,
    ma_datetime timestamp without time zone,
    ma_timestamp integer,
    ma_createdby character varying(80) COLLATE public.nocase,
    ma_createdate timestamp without time zone,
    ma_modifedby character varying(80) COLLATE public.nocase,
    ma_modifydate timestamp without time zone,
    ma_year_desc character varying(80) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    lo_id character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_macaccountingyear_pkey PRIMARY KEY (macaccountingyear_key),
    CONSTRAINT d_macaccountingyear_ukey UNIQUE (ou_id, company_code, ma_acc_yr_no, ma_start_date, ma_end_date)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_macaccountingyear
    OWNER to proconnect;
-- Index: d_macaccountingyear_key_idx1

-- DROP INDEX IF EXISTS dwh.d_macaccountingyear_key_idx1;

CREATE INDEX IF NOT EXISTS d_macaccountingyear_key_idx1
    ON dwh.d_macaccountingyear USING btree
    (ou_id ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, ma_acc_yr_no COLLATE public.nocase ASC NULLS LAST, ma_start_date ASC NULLS LAST, ma_end_date ASC NULLS LAST)
    TABLESPACE pg_default;