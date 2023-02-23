-- Table: raw.raw_fch_lock_settings_dtl

-- DROP TABLE IF EXISTS "raw".raw_fch_lock_settings_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_fch_lock_settings_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    guid character varying(512) COLLATE public.nocase NOT NULL,
    fin_year_dtl character varying(1020) COLLATE public.nocase,
    fin_period_dtl character varying(1020) COLLATE public.nocase,
    bus_fnc_grp_dtl character varying(1020) COLLATE public.nocase,
    ou_id_dtl integer,
    fin_book_dtl character varying(80) COLLATE public.nocase,
    lock_flag integer,
    excep_user_id character varying(120) COLLATE public.nocase,
    ml_flag character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT fchlocksettingsdtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_fch_lock_settings_dtl
    OWNER to proconnect;