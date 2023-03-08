-- Table: stg.stg_ainv_asset_transfer_out_hdr

-- DROP TABLE IF EXISTS stg.stg_ainv_asset_transfer_out_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_ainv_asset_transfer_out_hdr
(
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    no_type character varying(40) COLLATE public.nocase,
    status character varying(100) COLLATE public.nocase,
    confirm_reqd character varying(48) COLLATE public.nocase,
    tax_amount numeric,
    transfer_date character varying(100) COLLATE public.nocase,
    tcal_status character varying(48) COLLATE public.nocase,
    tcal_exclusive_amt numeric,
    total_tcal_amount numeric,
    transfer_in_no character varying(72) COLLATE public.nocase,
    receipt_date timestamp without time zone,
    transfer_in_status character varying(100) COLLATE public.nocase,
    tcal_status_in character varying(48) COLLATE public.nocase,
    tcal_exclusive_amt_in numeric,
    total_tcal_amount_in numeric,
    "timestamp" integer,
    no_type_in character varying(40) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate character varying(100) COLLATE public.nocase,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate character varying(100) COLLATE public.nocase,
    transfer_in_ou integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT ainv_asset_transfer_out_hdr_pk UNIQUE (tran_type, tran_ou, tran_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ainv_asset_transfer_out_hdr
    OWNER to proconnect;
-- Index: stg_ainv_asset_transfer_out_hdr_key_idx2

-- DROP INDEX IF EXISTS stg.stg_ainv_asset_transfer_out_hdr_key_idx2;

CREATE INDEX IF NOT EXISTS stg_ainv_asset_transfer_out_hdr_key_idx2
    ON stg.stg_ainv_asset_transfer_out_hdr USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;