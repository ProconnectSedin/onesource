-- Table: stg.stg_fbp_act_bal_prd

-- DROP TABLE IF EXISTS stg.stg_fbp_act_bal_prd;

CREATE TABLE IF NOT EXISTS stg.stg_fbp_act_bal_prd
(
    company_code character varying(20) COLLATE public.nocase,
    fin_year character varying(30) COLLATE public.nocase,
    fin_period character varying(30) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    finprd_startdt timestamp without time zone,
    sequenceno integer,
    etlcreatedatetime timestamp(3) without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_fbp_act_bal_prd
    OWNER to proconnect;