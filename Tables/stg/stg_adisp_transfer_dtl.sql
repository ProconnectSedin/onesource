-- Table: stg.stg_adisp_transfer_dtl

-- DROP TABLE IF EXISTS stg.stg_adisp_transfer_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_adisp_transfer_dtl
(
    transfer_number character varying(72) COLLATE public.nocase NOT NULL,
    ou_id integer NOT NULL,
    asset_number character varying(72) COLLATE public.nocase NOT NULL,
    tag_number integer NOT NULL,
    "timestamp" integer NOT NULL,
    asset_grp character varying(100) COLLATE public.nocase,
    asset_class character varying(80) COLLATE public.nocase,
    asset_location character varying(80) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    asset_cost numeric,
    cum_depr_amount numeric,
    asset_book_value numeric,
    remarks character varying(400) COLLATE public.nocase,
    receiving_location character varying(80) COLLATE public.nocase,
    receiving_cost_center character varying(40) COLLATE public.nocase,
    receipt_remarks character varying(400) COLLATE public.nocase,
    transfer_status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    line_no integer,
    transfer_in_no character varying(72) COLLATE public.nocase,
    transfer_in_status character varying(100) COLLATE public.nocase,
    par_base_book_value numeric,
    exchange_rate numeric,
    par_exchange_rate numeric,
    tran_currency character varying(20) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT adisp_transfer_dtl_pkey PRIMARY KEY (transfer_number, ou_id, asset_number, tag_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_adisp_transfer_dtl
    OWNER to proconnect;
-- Index: stg_adisp_transfer_dtl_idx

-- DROP INDEX IF EXISTS stg.stg_adisp_transfer_dtl_idx;

CREATE INDEX IF NOT EXISTS stg_adisp_transfer_dtl_idx
    ON stg.stg_adisp_transfer_dtl USING btree
    (transfer_number COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST)
    TABLESPACE pg_default;