-- Table: stg.stg_supp_threshold_trans

-- DROP TABLE IF EXISTS stg.stg_supp_threshold_trans;

CREATE TABLE IF NOT EXISTS stg.stg_supp_threshold_trans
(
    tran_no character varying(72) COLLATE public.nocase,
    tran_ou integer,
    tran_type character varying(160) COLLATE public.nocase,
    tran_amount numeric,
    tran_status character varying(100) COLLATE public.nocase,
    supplier_code character varying(64) COLLATE public.nocase,
    tax_type character varying(100) COLLATE public.nocase,
    tax_community character varying(100) COLLATE public.nocase,
    tax_region character varying(40) COLLATE public.nocase,
    tax_category character varying(160) COLLATE public.nocase,
    tax_class character varying(160) COLLATE public.nocase,
    tran_date timestamp without time zone,
    tax_code character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_supp_threshold_trans
    OWNER to proconnect;
-- Index: stg_supp_threshold_trans_key_idx2

-- DROP INDEX IF EXISTS stg.stg_supp_threshold_trans_key_idx2;

CREATE INDEX IF NOT EXISTS stg_supp_threshold_trans_key_idx2
    ON stg.stg_supp_threshold_trans USING btree
    (tran_no COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, tax_type COLLATE public.nocase ASC NULLS LAST, tax_community COLLATE public.nocase ASC NULLS LAST, tax_region COLLATE public.nocase ASC NULLS LAST, tax_category COLLATE public.nocase ASC NULLS LAST, tax_class COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;