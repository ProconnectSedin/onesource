-- Table: dwh.d_macaccountingperiod

-- DROP TABLE IF EXISTS dwh.d_macaccountingperiod;

CREATE TABLE IF NOT EXISTS dwh.d_macaccountingperiod
(
    macaccountingperiod_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    company_code character varying(20) COLLATE public.nocase,
    ma_acc_yr_no character varying(30) COLLATE public.nocase,
    ma_acc_prd_no character varying(30) COLLATE public.nocase,
    ma_acc_prd_desc character varying(80) COLLATE public.nocase,
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
    bu_id character varying(40) COLLATE public.nocase,
    lo_id character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_macaccountingperiod_pkey PRIMARY KEY (macaccountingperiod_key),
    CONSTRAINT d_macaccountingperiod_ukey UNIQUE (ou_id, company_code, ma_acc_yr_no, ma_acc_prd_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_macaccountingperiod
    OWNER to proconnect;