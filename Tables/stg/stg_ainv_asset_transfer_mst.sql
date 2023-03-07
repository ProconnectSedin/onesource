-- Table: stg.stg_ainv_asset_transfer_mst

-- DROP TABLE IF EXISTS stg.stg_ainv_asset_transfer_mst;

CREATE TABLE IF NOT EXISTS stg.stg_ainv_asset_transfer_mst
(
    "timestamp" integer,
    ou_id integer,
    transfer_date timestamp without time zone,
    asset_number character varying(72) COLLATE public.nocase,
    tag_number integer,
    recv_loc_code character varying(80) COLLATE public.nocase,
    recv_cost_center character varying(40) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    asset_loc_code character varying(80) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    asset_class_code character varying(80) COLLATE public.nocase,
    asset_group_code character varying(100) COLLATE public.nocase,
    asset_desc character varying(160) COLLATE public.nocase,
    tag_desc character varying(160) COLLATE public.nocase,
    confirm_reqd character varying(48) COLLATE public.nocase,
    confirm_date timestamp without time zone,
    confirm_status character varying(100) COLLATE public.nocase,
    bu_id character varying(80) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    dest_ouid integer,
    line_no integer,
    tran_out_no character varying(72) COLLATE public.nocase,
    tran_in_no character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ainv_asset_transfer_mst
    OWNER to proconnect;
-- Index: stg_ainv_asset_transfer_mst_key_idx2

-- DROP INDEX IF EXISTS stg.stg_ainv_asset_transfer_mst_key_idx2;

CREATE INDEX IF NOT EXISTS stg_ainv_asset_transfer_mst_key_idx2
    ON stg.stg_ainv_asset_transfer_mst USING btree
    (ou_id ASC NULLS LAST, transfer_date ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;