-- Table: raw.raw_wms_virtual_stockbal_lot

-- DROP TABLE IF EXISTS "raw".raw_wms_virtual_stockbal_lot;

CREATE TABLE IF NOT EXISTS "raw".raw_wms_virtual_stockbal_lot
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    sbl_wh_code character varying(40) COLLATE public.nocase NOT NULL,
    sbl_ouinstid integer NOT NULL,
    sbl_line_no integer NOT NULL,
    sbl_item_code character varying(128) COLLATE public.nocase,
    sbl_lot_no character varying(112) COLLATE public.nocase,
    sbl_zone character varying(40) COLLATE public.nocase,
    sbl_bin character varying(40) COLLATE public.nocase,
    sbl_stock_status character varying(24) COLLATE public.nocase,
    sbl_from_zone character varying(40) COLLATE public.nocase,
    sbl_from_bin character varying(40) COLLATE public.nocase,
    sbl_ref_doc_no character varying(72) COLLATE public.nocase,
    sbl_ref_doc_type character varying(32) COLLATE public.nocase,
    sbl_ref_doc_date timestamp without time zone,
    sbl_ref_doc_line_no integer,
    sbl_disposal_doc_type character varying(32) COLLATE public.nocase,
    sbl_disposal_doc_no character varying(72) COLLATE public.nocase,
    sbl_disposal_doc_date timestamp without time zone,
    sbl_disposal_status character varying(32) COLLATE public.nocase,
    sbl_quantity numeric,
    sbl_wh_bat_no character varying(112) COLLATE public.nocase,
    sbl_supp_bat_no character varying(112) COLLATE public.nocase,
    sbl_ido_no character varying(72) COLLATE public.nocase,
    sbl_gr_no character varying(72) COLLATE public.nocase,
    sbl_created_date timestamp without time zone,
    sbl_created_by character varying(120) COLLATE public.nocase,
    sbl_modified_date timestamp without time zone,
    sbl_modified_by character varying(120) COLLATE public.nocase,
    sbl_to_zone character varying(40) COLLATE public.nocase,
    sbl_to_bin character varying(40) COLLATE public.nocase,
    sbl_reason_code character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_wms_virtual_stockbal_lot_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_wms_virtual_stockbal_lot
    OWNER to proconnect;