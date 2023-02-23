-- Table: raw.raw_si_act_bal_prd

-- DROP TABLE IF EXISTS "raw".raw_si_act_bal_prd;

CREATE TABLE IF NOT EXISTS "raw".raw_si_act_bal_prd
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(40) COLLATE public.nocase,
    fin_year character varying(60) COLLATE public.nocase,
    fin_period character varying(60) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    finprd_startdt timestamp without time zone,
    sequenceno integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_si_act_bal_prd_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_si_act_bal_prd
    OWNER to proconnect;