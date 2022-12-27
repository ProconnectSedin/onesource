CREATE TABLE stg.stg_wms_pack_plan_dtl (
    wms_pack_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pack_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_pack_pln_ou integer NOT NULL,
    wms_pack_lineno integer NOT NULL,
    wms_pack_picklist_no character varying(72) COLLATE public.nocase,
    wms_pack_so_no character varying(72) COLLATE public.nocase,
    wms_pack_so_line_no integer,
    wms_pack_so_sch_lineno integer,
    wms_pack_item_code character varying(128) COLLATE public.nocase,
    wms_pack_item_batch_no character varying(112) COLLATE public.nocase,
    wms_pack_item_sr_no character varying(112) COLLATE public.nocase,
    wms_pack_so_qty numeric,
    wms_pack_uid_sr_no character varying(112) COLLATE public.nocase,
    wms_pack_thu_sr_no character varying(112) COLLATE public.nocase,
    wms_pack_pre_packing_bay character varying(72) COLLATE public.nocase,
    wms_pack_lot_no character varying(112) COLLATE public.nocase,
    wms_pack_su character varying(40) COLLATE public.nocase,
    wms_pack_su_type character varying(32) COLLATE public.nocase,
    wms_pack_thu_id character varying(160) COLLATE public.nocase,
    wms_pack_plan_qty numeric,
    wms_pack_allocated_qty numeric,
    wms_pack_tolerance_qty numeric,
    wms_pack_cons character varying(160) COLLATE public.nocase,
    wms_pack_customer_serial_no character varying(112) COLLATE public.nocase,
    wms_pack_warranty_serial_no character varying(112) COLLATE public.nocase,
    wms_pack_packed_from_uid_serno character varying(112) COLLATE public.nocase,
    wms_pack_source_thu_ser_no character varying(160) COLLATE public.nocase,
    wms_pack_box_thu_id character varying(160) COLLATE public.nocase,
    wms_pack_box_no character varying(72) COLLATE public.nocase,
    wms_pack_reason_code character varying(160) COLLATE public.nocase,
    wms_pack_item_attribute1 character varying(1020) COLLATE public.nocase,
    wms_pack_item_attribute2 character varying(1020) COLLATE public.nocase,
    wms_pack_item_attribute3 character varying(1020) COLLATE public.nocase,
    wms_pack_item_attribute4 character varying(1020) COLLATE public.nocase,
    wms_pack_item_attribute5 character varying(1020) COLLATE public.nocase,
    wms_pack_item_attribute6 character varying(1020) COLLATE public.nocase,
    wms_pack_item_attribute7 character varying(1020) COLLATE public.nocase,
    wms_pack_item_attribute8 character varying(1020) COLLATE public.nocase,
    wms_pack_item_attribute9 character varying(1020) COLLATE public.nocase,
    wms_pack_item_attribute10 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_pack_plan_dtl
    ADD CONSTRAINT wms_pack_plan_dtl_pk PRIMARY KEY (wms_pack_loc_code, wms_pack_pln_no, wms_pack_pln_ou, wms_pack_lineno);

CREATE INDEX stg_wms_pack_plan_dtl_idx ON stg.stg_wms_pack_plan_dtl USING btree (wms_pack_pln_ou, wms_pack_loc_code, wms_pack_pln_no, wms_pack_lineno);

CREATE INDEX stg_wms_pack_plan_dtl_idx1 ON stg.stg_wms_pack_plan_dtl USING btree (wms_pack_pln_ou, wms_pack_loc_code);

CREATE INDEX stg_wms_pack_plan_dtl_idx2 ON stg.stg_wms_pack_plan_dtl USING btree (wms_pack_pln_ou, wms_pack_item_code);

CREATE INDEX stg_wms_pack_plan_dtl_idx3 ON stg.stg_wms_pack_plan_dtl USING btree (wms_pack_pln_ou, wms_pack_thu_id);