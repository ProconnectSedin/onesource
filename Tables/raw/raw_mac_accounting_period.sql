-- Table: raw.raw_mac_accounting_period

-- DROP TABLE IF EXISTS "raw".raw_mac_accounting_period;

CREATE TABLE IF NOT EXISTS "raw".raw_mac_accounting_period
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_mac_accounting_period_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_mac_accounting_period
    OWNER to proconnect;