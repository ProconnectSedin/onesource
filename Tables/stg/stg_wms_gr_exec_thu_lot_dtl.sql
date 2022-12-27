CREATE TABLE stg.stg_wms_gr_exec_thu_lot_dtl (
    wms_gr_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gr_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_gr_exec_ou integer NOT NULL,
    wms_gr_thu_id character varying(160) NOT NULL COLLATE public.nocase,
    wms_gr_lot_thu_sno character varying(112) NOT NULL COLLATE public.nocase,
    wms_gr_line_no integer NOT NULL,
    wms_gr_item_line_no integer NOT NULL,
    wms_gr_item_code character varying(128) COLLATE public.nocase,
    wms_gr_lot_no character varying(112) COLLATE public.nocase,
    wms_gr_supp_bat_no character varying(112) COLLATE public.nocase,
    wms_gr_qty numeric,
    wms_gr_thu_uid_sr_no character varying(160) NOT NULL COLLATE public.nocase,
    wms_gr_thu_lot_su character varying(40) NOT NULL COLLATE public.nocase,
    wms_gr_thu_uid2_ser_no character varying(112) COLLATE public.nocase,
    wms_gr_thu_su2 character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_gr_exec_thu_lot_dtl
    ADD CONSTRAINT wms_gr_exec_thu_lot_dtl_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_exec_no, wms_gr_exec_ou, wms_gr_thu_id, wms_gr_lot_thu_sno, wms_gr_line_no, wms_gr_thu_uid_sr_no, wms_gr_thu_lot_su);