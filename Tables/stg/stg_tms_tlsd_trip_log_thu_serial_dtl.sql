CREATE TABLE stg.stg_tms_tlsd_trip_log_thu_serial_dtl (
    tlsd_ouinstance integer,
    tlsd_trip_id character varying(160) COLLATE public.nocase,
    tlsd_br_id character varying(160) COLLATE public.nocase,
    tlsd_thu_id character varying(160) COLLATE public.nocase,
    tlsd_serial_no character varying(160) COLLATE public.nocase,
    tlsd_guid character varying(512) COLLATE public.nocase,
    tlsd_seq_no integer,
    tlsd_dispatch_no character varying(72) COLLATE public.nocase,
    tlsd_thu_line character varying(512) COLLATE public.nocase,
    tlsd_thu_serial_line character varying(512) COLLATE public.nocase,
    tlsd_seal_no character varying(160) COLLATE public.nocase,
    tlsd_timestamp integer,
    tlsd_created_date timestamp without time zone,
    tlsd_created_by character varying(120) COLLATE public.nocase,
    tlsd_modified_date timestamp without time zone,
    tlsd_modified_by character varying(120) COLLATE public.nocase,
    tlsd_length numeric,
    tlsd_hight numeric,
    tlsd_breadth numeric,
    tlsd_lbh_uom character varying(60) COLLATE public.nocase,
    tlsd_customer_serial_no character varying(160) COLLATE public.nocase,
    tlsd_approval_for_hzmt_cmpltd character varying(160) COLLATE public.nocase,
    tlsd_dg_class character varying(160) COLLATE public.nocase,
    tlsd_hs_code character varying(160) COLLATE public.nocase,
    tlsd_un_code character varying(160) COLLATE public.nocase,
    tlsd_class_of_stores character varying(160) COLLATE public.nocase,
    tlsd_planned_qty numeric,
    tlsd_thu_actual_qty numeric,
    tlsd_actual_planned_mismatch_reason character varying(160) COLLATE public.nocase,
    tlsd_damaged_qty numeric,
    tlsd_rsncode_damage character varying(160) COLLATE public.nocase,
    tlsd_returned_qty numeric,
    tlsd_returned_reasoncode character varying(160) COLLATE public.nocase,
    tlsd_reasoncode_remarks character varying(1020) COLLATE public.nocase,
    tlsd_planned_palletspace integer,
    tlsd_actual_palletspace integer,
    tlsd_thu_weight numeric,
    tlsd_thu_weight_uom character varying(60) COLLATE public.nocase,
    tlsd_volume numeric,
    tlsd_volume_uom character varying(60) COLLATE public.nocase,
    tlsd_transfer_type character varying(160) COLLATE public.nocase,
    tlsd_vendor_thu_id character varying(160) COLLATE public.nocase,
    tlsd_vendor_doc_no character varying(160) COLLATE public.nocase,
    tlsd_vendor_ac_no character varying(160) COLLATE public.nocase,
    tlsd_copy_rsncode integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);