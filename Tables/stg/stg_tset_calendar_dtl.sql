-- Table: stg.stg_tset_calendar_dtl

-- DROP TABLE IF EXISTS stg.stg_tset_calendar_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_tset_calendar_dtl
(
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
    etlcreatedatetime timestamp(3) without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_tset_calendar_dtl
    OWNER to proconnect;