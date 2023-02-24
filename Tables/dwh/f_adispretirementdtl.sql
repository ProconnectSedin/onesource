-- Table: dwh.f_adispretirementdtl

-- DROP TABLE IF EXISTS dwh.f_adispretirementdtl;

CREATE TABLE IF NOT EXISTS dwh.f_adispretirementdtl
(
    adispretirementdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    adispretirementdtl_lockey bigint,
    adispretirementdtl_currkey bigint,
    asset_number character varying(40) COLLATE public.nocase,
    tag_number integer,
    ou_id integer,
    retirement_number character varying(40) COLLATE public.nocase,
    asset_location character varying(40) COLLATE public.nocase,
    asset_class character varying(40) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    asset_cost numeric(20,2),
    cum_depr_amount numeric(20,2),
    asset_book_value numeric(20,2),
    retirement_mode character varying(50) COLLATE public.nocase,
    retirement_date timestamp without time zone,
    customer character varying(40) COLLATE public.nocase,
    claim_insurance character varying(20) COLLATE public.nocase,
    sale_value numeric(20,2),
    gain_loss numeric(20,2),
    remarks character varying(200) COLLATE public.nocase,
    tag_status character varying(10) COLLATE public.nocase,
    reversal_number character varying(40) COLLATE public.nocase,
    reverse_remarks character varying(200) COLLATE public.nocase,
    invoice_number character varying(40) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    inv_currency character varying(10) COLLATE public.nocase,
    exchange_rate numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_adispretirementdtl_pkey PRIMARY KEY (adispretirementdtl_key),
    CONSTRAINT f_adispretirementdtl_ukey UNIQUE (asset_number, tag_number, ou_id, retirement_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_adispretirementdtl
    OWNER to proconnect;
-- Index: f_adispretirementdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_adispretirementdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_adispretirementdtl_key_idx
    ON dwh.f_adispretirementdtl USING btree
    (asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, ou_id ASC NULLS LAST, retirement_number COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;