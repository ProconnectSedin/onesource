-- Table: dwh.d_tsetcalendardtl

-- DROP TABLE IF EXISTS dwh.d_tsetcalendardtl;

CREATE TABLE IF NOT EXISTS dwh.d_tsetcalendardtl
(
    tset_calendar_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(20) COLLATE public.nocase,
    declaration_year character varying(20) COLLATE public.nocase,
    declaration_period character varying(30) COLLATE public.nocase,
    pay_due_date timestamp without time zone,
    declaration_period_desc character varying(80) COLLATE public.nocase,
    start_date timestamp without time zone,
    status character varying(10) COLLATE public.nocase,
    end_date timestamp without time zone,
    created_at integer,
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_tset_calendar_dtl_pkey PRIMARY KEY (tset_calendar_dtl_key),
    CONSTRAINT d_tset_calendar_dtl_ukey UNIQUE (company_code, declaration_year, declaration_period)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_tsetcalendardtl
    OWNER to proconnect;