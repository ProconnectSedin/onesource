-- Table: raw.raw_amig_initial_balance

-- DROP TABLE IF EXISTS "raw".raw_amig_initial_balance;

CREATE TABLE IF NOT EXISTS "raw".raw_amig_initial_balance
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    depr_book character varying(80) COLLATE public.nocase NOT NULL,
    fin_year character varying(40) COLLATE public.nocase NOT NULL,
    fin_period character varying(40) COLLATE public.nocase NOT NULL,
    asset_number character varying(72) COLLATE public.nocase NOT NULL,
    tag_number integer NOT NULL,
    fb_id character varying(80) COLLATE public.nocase NOT NULL,
    asset_class character varying(80) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    asset_cost numeric,
    depr_charge numeric,
    cum_depr_charge numeric,
    reval_type character varying(48) COLLATE public.nocase,
    reval_date timestamp without time zone,
    reval_amount numeric,
    rev_dep_cost numeric,
    asset_book_val numeric,
    complete_status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_amig_initial_balance_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_amig_initial_balance
    OWNER to proconnect;