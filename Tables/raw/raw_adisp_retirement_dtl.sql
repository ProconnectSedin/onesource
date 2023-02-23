-- Table: raw.raw_adisp_retirement_dtl

-- DROP TABLE IF EXISTS "raw".raw_adisp_retirement_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_adisp_retirement_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    asset_number character varying(72) COLLATE public.nocase NOT NULL,
    tag_number integer NOT NULL,
    ou_id integer NOT NULL,
    retirement_number character varying(72) COLLATE public.nocase NOT NULL,
    "timestamp" integer NOT NULL,
    asset_location character varying(80) COLLATE public.nocase,
    asset_class character varying(80) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    asset_cost numeric,
    cum_depr_amount numeric,
    asset_book_value numeric,
    retirement_mode character varying(100) COLLATE public.nocase,
    retirement_date timestamp without time zone,
    customer character varying(72) COLLATE public.nocase,
    claim_insurance character varying(40) COLLATE public.nocase,
    sale_value numeric,
    gain_loss numeric,
    remarks character varying(400) COLLATE public.nocase,
    tag_status character varying(8) COLLATE public.nocase,
    reversal_number character varying(72) COLLATE public.nocase,
    reverse_remarks character varying(400) COLLATE public.nocase,
    invoice_number character varying(72) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    cum_imp_loss numeric,
    inv_currency character varying(20) COLLATE public.nocase,
    exchange_rate numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT adisp_retirement_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_adisp_retirement_dtl
    OWNER to proconnect;