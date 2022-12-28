CREATE TABLE raw.raw_wms_virtual_stockbal_lot (
    raw_id bigint NOT NULL,
    sbl_wh_code character varying(40) NOT NULL COLLATE public.nocase,
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_virtual_stockbal_lot ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_virtual_stockbal_lot_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_virtual_stockbal_lot
    ADD CONSTRAINT raw_wms_virtual_stockbal_lot_pkey PRIMARY KEY (raw_id);