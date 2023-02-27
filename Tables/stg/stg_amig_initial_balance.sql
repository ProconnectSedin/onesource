-- Table: stg.stg_amig_initial_balance

-- DROP TABLE IF EXISTS stg.stg_amig_initial_balance;

CREATE TABLE IF NOT EXISTS stg.stg_amig_initial_balance
(
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
    CONSTRAINT amig_initial_balance_pkey PRIMARY KEY (ou_id, depr_book, fin_year, fin_period, asset_number, tag_number, fb_id, asset_class)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_amig_initial_balance
    OWNER to proconnect;
-- Index: stg_amig_initial_balance_idx

-- DROP INDEX IF EXISTS stg.stg_amig_initial_balance_idx;

CREATE INDEX IF NOT EXISTS stg_amig_initial_balance_idx
    ON stg.stg_amig_initial_balance USING btree
    (ou_id ASC NULLS LAST, depr_book COLLATE public.nocase ASC NULLS LAST, fin_year COLLATE public.nocase ASC NULLS LAST, fin_period COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, asset_class COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;