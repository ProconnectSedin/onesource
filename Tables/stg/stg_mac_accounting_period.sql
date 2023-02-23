-- Table: stg.stg_mac_accounting_period

-- DROP TABLE IF EXISTS stg.stg_mac_accounting_period;

CREATE TABLE IF NOT EXISTS stg.stg_mac_accounting_period
(
    ou_id integer NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    ma_acc_yr_no character varying(60) COLLATE public.nocase NOT NULL,
    ma_acc_prd_no character varying(60) COLLATE public.nocase NOT NULL,
    ma_acc_prd_desc character varying(160) COLLATE public.nocase,
    ma_start_date timestamp without time zone NOT NULL,
    ma_end_date timestamp without time zone NOT NULL,
    ma_status character varying(4) COLLATE public.nocase NOT NULL,
    ma_user_id integer NOT NULL,
    ma_datetime timestamp without time zone NOT NULL,
    ma_timestamp integer,
    ma_createdby character varying(160) COLLATE public.nocase,
    ma_createdate timestamp without time zone,
    ma_modifedby character varying(160) COLLATE public.nocase,
    ma_modifydate timestamp without time zone,
    bu_id character varying(80) COLLATE public.nocase,
    lo_id character varying(80) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_mac_accounting_period
    OWNER to proconnect;