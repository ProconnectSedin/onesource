-- Table: stg.stg_wms_virtual_stockbal_lot

-- DROP TABLE IF EXISTS stg.stg_wms_virtual_stockbal_lot;	
	
CREATE TABLE IF NOT EXISTS stg.stg_wms_virtual_stockbal_lot
(
    sbl_wh_code character varying(20) COLLATE pg_catalog."default",
    sbl_ouinstid integer,
    sbl_line_no integer,
    sbl_item_code character varying(80) COLLATE pg_catalog."default",
    sbl_lot_no character varying(60) COLLATE pg_catalog."default",
    sbl_zone character varying(20) COLLATE pg_catalog."default",
    sbl_bin character varying(20) COLLATE pg_catalog."default",
    sbl_stock_status character varying(20) COLLATE pg_catalog."default",
    sbl_from_zone character varying(20) COLLATE pg_catalog."default",
    sbl_from_bin character varying(20) COLLATE pg_catalog."default",
    sbl_ref_doc_no character varying(40) COLLATE pg_catalog."default",
    sbl_ref_doc_type character varying(20) COLLATE pg_catalog."default",
    sbl_ref_doc_date timestamp without time zone,
    sbl_ref_doc_line_no integer,
    sbl_disposal_doc_type character varying(20) COLLATE pg_catalog."default",
    sbl_disposal_doc_no character varying(40) COLLATE pg_catalog."default",
    sbl_disposal_doc_date timestamp without time zone,
    sbl_disposal_status character varying(20) COLLATE pg_catalog."default",
    sbl_quantity numeric(25,2),
    sbl_wh_bat_no character varying(60) COLLATE pg_catalog."default",
    sbl_supp_bat_no character varying(60) COLLATE pg_catalog."default",
    sbl_ido_no character varying(40) COLLATE pg_catalog."default",
    sbl_gr_no character varying(40) COLLATE pg_catalog."default",
    sbl_created_date timestamp without time zone,
    sbl_created_by character varying(60) COLLATE pg_catalog."default",
    sbl_modified_date timestamp without time zone,
    sbl_modified_by character varying(60) COLLATE pg_catalog."default",
    sbl_to_zone character varying(20) COLLATE pg_catalog."default",
    sbl_to_bin character varying(20) COLLATE pg_catalog."default",
    sbl_reason_code character varying(80) COLLATE pg_catalog."default",
    etlcreatedatetime timestamp(3) without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_wms_virtual_stockbal_lot
    OWNER to proconnect;

CREATE INDEX IF NOT EXISTS stg_wms_virtual_stockbal_lot_idx
    ON stg.stg_wms_virtual_stockbal_lot USING btree
	(sbl_wh_code, sbl_ouinstid);
CREATE INDEX IF NOT EXISTS stg_wms_virtual_stockbal_lot_idx1
    ON stg.stg_wms_virtual_stockbal_lot USING btree
	(sbl_item_code, sbl_ouinstid);
CREATE INDEX IF NOT EXISTS stg_wms_virtual_stockbal_lot_idx2
    ON stg.stg_wms_virtual_stockbal_lot USING btree
	(sbl_wh_code, sbl_ouinstid, sbl_line_no);