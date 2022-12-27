CREATE TABLE stg.stg_wms_stock_bin_history_dtl (
    wms_stock_ou integer NOT NULL,
    wms_stock_date timestamp without time zone NOT NULL,
    wms_stock_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_stock_zone character varying(40) NOT NULL COLLATE public.nocase,
    wms_stock_bin character varying(40) NOT NULL COLLATE public.nocase,
    wms_stock_bin_type character varying(80) COLLATE public.nocase,
    wms_stock_customer character varying(72) COLLATE public.nocase,
    wms_stock_item character varying(128) NOT NULL COLLATE public.nocase,
    wms_stock_opening_bal numeric,
    wms_stock_in_qty numeric,
    wms_stock_out_qty numeric,
    wms_stock_bin_qty numeric,
    wms_stock_thu_id character varying(160) NOT NULL COLLATE public.nocase,
    wms_stock_su_opening_bal numeric,
    wms_stock_su_count_qty_in numeric,
    wms_stock_su_count_qty_out numeric,
    wms_stock_su_count_qty_bal numeric,
    wms_stock_su character varying(40) DEFAULT ''::character varying NOT NULL COLLATE public.nocase,
    wms_stock_thu_opening_bal numeric,
    wms_stock_thu_count_qty_in numeric,
    wms_stock_thu_count_qty_out numeric,
    wms_stock_thu_count_qty_bal numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_stock_bin_history_dtl
    ADD CONSTRAINT wms_stock_bin_history_dtl_pk PRIMARY KEY (wms_stock_ou, wms_stock_date, wms_stock_location, wms_stock_zone, wms_stock_bin, wms_stock_item, wms_stock_thu_id, wms_stock_su);

CREATE INDEX stg_wms_stock_bin_history_dtl_idx1 ON stg.stg_wms_stock_bin_history_dtl USING btree (wms_stock_ou, wms_stock_bin, wms_stock_location, wms_stock_zone, wms_stock_bin_type, wms_stock_date, wms_stock_item, wms_stock_thu_id, wms_stock_su);

CREATE INDEX stg_wms_stock_bin_history_dtl_idx2 ON stg.stg_wms_stock_bin_history_dtl USING btree (wms_stock_location, wms_stock_ou);

CREATE INDEX stg_wms_stock_bin_history_dtl_idx3 ON stg.stg_wms_stock_bin_history_dtl USING btree (wms_stock_item, wms_stock_ou);

CREATE INDEX stg_wms_stock_bin_history_dtl_idx4 ON stg.stg_wms_stock_bin_history_dtl USING btree (wms_stock_customer, wms_stock_ou);

CREATE INDEX stg_wms_stock_bin_history_dtl_idx5 ON stg.stg_wms_stock_bin_history_dtl USING btree (wms_stock_thu_id, wms_stock_ou);