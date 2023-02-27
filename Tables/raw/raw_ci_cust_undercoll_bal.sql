-- Table: raw.raw_ci_cust_undercoll_bal

-- DROP TABLE IF EXISTS "raw".raw_ci_cust_undercoll_bal;

CREATE TABLE IF NOT EXISTS "raw".raw_ci_cust_undercoll_bal
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    lo_id character varying(80) COLLATE public.nocase,
    bu_id character varying(80) COLLATE public.nocase,
    ou_id integer,
    fb_id character varying(80) COLLATE public.nocase,
    company_code character varying(40) COLLATE public.nocase,
    cust_code character varying(72) COLLATE public.nocase,
    base_currency_code character varying(20) COLLATE public.nocase,
    balance_type character varying(20) COLLATE public.nocase,
    par_currency_code character varying(20) COLLATE public.nocase,
    "timestamp" integer,
    deposit_amount numeric,
    realized_amount numeric,
    undercoll_amount numeric,
    par_deposit_amount numeric,
    par_undercoll_amount numeric,
    par_realized_amount numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_ci_cust_undercoll_bal_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_ci_cust_undercoll_bal
    OWNER to proconnect;