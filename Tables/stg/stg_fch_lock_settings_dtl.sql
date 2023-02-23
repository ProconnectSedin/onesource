-- Table: stg.stg_fch_lock_settings_dtl

-- DROP TABLE IF EXISTS stg.stg_fch_lock_settings_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_fch_lock_settings_dtl
(
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_fch_lock_settings_dtl
    OWNER to proconnect;
-- Index: stg_fch_lock_settings_dtl_key_idx

-- DROP INDEX IF EXISTS stg.stg_fch_lock_settings_dtl_key_idx;

CREATE INDEX IF NOT EXISTS stg_fch_lock_settings_dtl_key_idx
    ON stg.stg_fch_lock_settings_dtl USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, guid COLLATE public.nocase ASC NULLS LAST, bus_fnc_grp_dtl COLLATE public.nocase ASC NULLS LAST, fin_book_dtl COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;