-- Table: dwh.d_siactbalprd

-- DROP TABLE IF EXISTS dwh.d_siactbalprd;

CREATE TABLE IF NOT EXISTS dwh.d_siactbalprd
(
    siactbalprd_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_key bigint,
    company_code character varying(20) COLLATE public.nocase,
    fin_year character varying(30) COLLATE public.nocase,
    fin_period character varying(30) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    finprd_startdt timestamp without time zone,
    sequenceno integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_siactbalprd_pkey PRIMARY KEY (siactbalprd_key),
    CONSTRAINT d_siactbalprd_ukey UNIQUE (company_code, fin_year, fin_period, fb_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_siactbalprd
    OWNER to proconnect;