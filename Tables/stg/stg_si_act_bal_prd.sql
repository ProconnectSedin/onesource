-- Table: stg.stg_si_act_bal_prd

-- DROP TABLE IF EXISTS stg.stg_si_act_bal_prd;

CREATE TABLE IF NOT EXISTS stg.stg_si_act_bal_prd
(
    company_code character varying(40) COLLATE public.nocase,
    fin_year character varying(60) COLLATE public.nocase,
    fin_period character varying(60) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    finprd_startdt timestamp without time zone,
    sequenceno integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_si_act_bal_prd
    OWNER to proconnect;