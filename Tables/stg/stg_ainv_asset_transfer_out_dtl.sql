-- Table: stg.stg_ainv_asset_transfer_out_dtl

-- DROP TABLE IF EXISTS stg.stg_ainv_asset_transfer_out_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_ainv_asset_transfer_out_dtl
(
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    tran_no character varying(72) COLLATE public.nocase NOT NULL,
    fb character varying(80) COLLATE public.nocase,
    asset_number character varying(72) COLLATE public.nocase,
    tag_number integer,
    recv_loc_code character varying(80) COLLATE public.nocase,
    recv_cost_center character varying(40) COLLATE public.nocase,
    asset_loc_code character varying(80) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    confirm_date character varying(100) COLLATE public.nocase,
    confirm_status character varying(100) COLLATE public.nocase,
    dest_ouid integer,
    book_value numeric,
    par_base_book_value numeric,
    exchange_rate numeric,
    par_exchange_rate numeric,
    tran_currency character varying(20) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    line_no integer,
    transfer_in_no character varying(72) COLLATE public.nocase,
    transfer_in_ou integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ainv_asset_transfer_out_dtl
    OWNER to proconnect;
-- Index: stg_ainv_asset_transfer_out_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_ainv_asset_transfer_out_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_ainv_asset_transfer_out_dtl_key_idx2
    ON stg.stg_ainv_asset_transfer_out_dtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, fb COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;