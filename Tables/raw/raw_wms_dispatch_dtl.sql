CREATE TABLE raw.raw_wms_dispatch_dtl (
    raw_id bigint NOT NULL,
    wms_dispatch_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_dispatch_ld_sheet_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_dispatch_ld_sheet_ou integer NOT NULL,
    wms_dispatch_lineno integer NOT NULL,
    wms_dispatch_so_no character varying(72) COLLATE public.nocase,
    wms_dispatch_thu_id character varying(160) COLLATE public.nocase,
    wms_dispatch_ship_point character varying(72) COLLATE public.nocase,
    wms_dispatch_ship_mode character varying(160) COLLATE public.nocase,
    wms_dispatch_pack_exec_no character varying(72) COLLATE public.nocase,
    wms_dispatch_customer character varying(72) COLLATE public.nocase,
    wms_dispatch_thu_desc character varying(1020) COLLATE public.nocase,
    wms_dispatch_thu_class character varying(160) COLLATE public.nocase,
    wms_dispatch_thu_sr_no character varying(112) COLLATE public.nocase,
    wms_dispatch_thu_acc integer,
    wms_dispatch_su character varying(40) COLLATE public.nocase,
    wms_dispatch_exec_stage character varying(100) COLLATE public.nocase,
    wms_dispatch_uid_serial_no character varying(112) COLLATE public.nocase,
    wms_dispatch_thu_weight numeric,
    wms_dispatch_thu_wt_uom character varying(40) COLLATE public.nocase,
    wms_dispatch_cons_qty numeric,
    wms_dispatch_cons_ml character varying(1020) COLLATE public.nocase,
    wms_dispatch_length_ml numeric,
    wms_dispatch_height_ml numeric,
    wms_dispatch_breadth_ml numeric,
    wms_dispatch_thu_sp_ml character varying(160) COLLATE public.nocase,
    wms_dispatch_uom_ml character varying(40) COLLATE public.nocase,
    wms_dispatch_vol_ml character varying(40) COLLATE public.nocase,
    wms_dispatch_vol_uom_ml numeric,
    wms_dispatch_outbound_no character varying(72) COLLATE public.nocase,
    wms_dispatch_reasoncode_ml character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_dispatch_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_dispatch_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_dispatch_dtl
    ADD CONSTRAINT raw_wms_dispatch_dtl_pkey PRIMARY KEY (raw_id);