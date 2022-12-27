CREATE TABLE raw.raw_wms_pack_exec_thu_dtl_hist (
    raw_id bigint NOT NULL,
    wms_pack_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pack_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_pack_exec_ou integer NOT NULL,
    wms_pack_thu_id character varying(160) NOT NULL COLLATE public.nocase,
    wms_pack_thu_lineno integer NOT NULL,
    wms_pack_picklist_no character varying(72) COLLATE public.nocase,
    wms_pack_so_no character varying(72) COLLATE public.nocase,
    wms_pack_so_line_no integer,
    wms_pack_so_sch_lineno integer,
    wms_pack_thu_item_code character varying(128) COLLATE public.nocase,
    wms_pack_thu_item_qty numeric,
    wms_pack_thu_pack_qty numeric,
    wms_pack_thu_item_batch_no character varying(112) COLLATE public.nocase,
    wms_pack_thu_item_sr_no character varying(112) COLLATE public.nocase,
    wms_pack_lot_no character varying(112) COLLATE public.nocase,
    wms_pack_thu_ser_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_pack_uid1_ser_no character varying(112) COLLATE public.nocase,
    wms_pack_uid_ser_no character varying(112) COLLATE public.nocase,
    wms_pack_allocated_qty numeric,
    wms_pack_planned_qty numeric,
    wms_pack_tolerance_qty numeric,
    wms_pack_uid_cons character varying(160) COLLATE public.nocase,
    wms_pack_packed_from_uid_serno character varying(112) COLLATE public.nocase,
    wms_pack_factory_pack character varying(80) COLLATE public.nocase,
    wms_pack_source_thu_ser_no character varying(160) COLLATE public.nocase,
    wms_pack_reason_code character varying(160) COLLATE public.nocase,
    wms_pack_created_by character varying(1020) COLLATE public.nocase,
    wms_pack_created_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_pack_exec_thu_dtl_hist ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_pack_exec_thu_dtl_hist_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_pack_exec_thu_dtl_hist
    ADD CONSTRAINT raw_wms_pack_exec_thu_dtl_hist_pkey PRIMARY KEY (raw_id);