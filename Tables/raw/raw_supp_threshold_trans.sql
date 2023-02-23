-- Table: raw.raw_supp_threshold_trans

-- DROP TABLE IF EXISTS "raw".raw_supp_threshold_trans;

CREATE TABLE IF NOT EXISTS "raw".raw_supp_threshold_trans
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT supp_threshold_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_supp_threshold_trans
    OWNER to proconnect;