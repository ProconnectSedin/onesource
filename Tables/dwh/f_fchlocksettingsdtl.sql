-- Table: dwh.f_fchlocksettingsdtl

-- DROP TABLE IF EXISTS dwh.f_fchlocksettingsdtl;

CREATE TABLE IF NOT EXISTS dwh.f_fchlocksettingsdtl
(
    fchlocksettingsdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    fchlocksettingsdtl_cmpkey bigint,
    company_code character varying(20) COLLATE public.nocase,
    guid character varying(256) COLLATE public.nocase,
    fin_year_dtl character varying(510) COLLATE public.nocase,
    fin_period_dtl character varying(510) COLLATE public.nocase,
    bus_fnc_grp_dtl character varying(510) COLLATE public.nocase,
    ou_id_dtl integer,
    fin_book_dtl character varying(40) COLLATE public.nocase,
    lock_flag integer,
    excep_user_id character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT fchlocksettingsdtl_pkey PRIMARY KEY (fchlocksettingsdtl_key),
    CONSTRAINT fchlocksettingsdtl_ukey UNIQUE (company_code, guid, bus_fnc_grp_dtl, fin_book_dtl)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_fchlocksettingsdtl
    OWNER to proconnect;
-- Index: f_fchlocksettingsdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_fchlocksettingsdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_fchlocksettingsdtl_key_idx
    ON dwh.f_fchlocksettingsdtl USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, guid COLLATE public.nocase ASC NULLS LAST, bus_fnc_grp_dtl COLLATE public.nocase ASC NULLS LAST, fin_book_dtl COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;