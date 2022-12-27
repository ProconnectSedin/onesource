CREATE TABLE stg.stg_wms_put_plan_item_dtl (
    wms_pway_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pway_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_pway_pln_ou integer NOT NULL,
    wms_pway_lineno integer NOT NULL,
    wms_pway_po_no character varying(72) COLLATE public.nocase,
    wms_pway_po_sr_no integer,
    wms_pway_uid character varying(160) COLLATE public.nocase,
    wms_pway_item character varying(128) COLLATE public.nocase,
    wms_pway_zone character varying(40) COLLATE public.nocase,
    wms_pway_allocated_qty numeric,
    wms_pway_allocated_bin character varying(40) COLLATE public.nocase,
    wms_pway_gr_no character varying(72) COLLATE public.nocase,
    wms_pway_gr_lineno integer,
    wms_pway_gr_lot_no character varying(112) COLLATE public.nocase,
    wms_pway_rqs_conformation integer,
    wms_pway_su_type character varying(32) COLLATE public.nocase,
    wms_pway_su_serial_no character varying(112) COLLATE public.nocase,
    wms_pway_su character varying(40) COLLATE public.nocase,
    wms_pway_from_staging_id character varying(72) COLLATE public.nocase,
    wms_pway_supp_batch_no character varying(112) COLLATE public.nocase,
    wms_pway_thu_serial_no character varying(160) COLLATE public.nocase,
    wms_pway_allocated_staging character varying(72) COLLATE public.nocase,
    wms_pway_cross_dock integer,
    wms_pway_target_thu_serial_no character varying(112) COLLATE public.nocase,
    wms_pway_stock_status character varying(32) COLLATE public.nocase,
    wms_pway_staging character varying(72) COLLATE public.nocase,
    wms_pway_su2 character varying(40) COLLATE public.nocase,
    wms_pway_su_serial_no2 character varying(112) COLLATE public.nocase,
    wms_put_su1_conv_flg character varying(32) COLLATE public.nocase,
    wms_put_su2_conv_flg character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_put_plan_item_dtl
    ADD CONSTRAINT wms_put_plan_item_dtl_pk PRIMARY KEY (wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou, wms_pway_lineno);

CREATE INDEX stg_wms_put_plan_item_dtl_key_idx1 ON stg.stg_wms_put_plan_item_dtl USING btree (wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou, wms_pway_lineno);