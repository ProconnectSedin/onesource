CREATE TABLE stg.stg_wms_pack_item_sr_dtl (
    wms_item_sl_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_item_sl_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_item_sl_ou integer NOT NULL,
    wms_item_sl_line_no integer NOT NULL,
    wms_item_sl_thuid character varying(160) NOT NULL COLLATE public.nocase,
    wms_item_sl_itm character varying(128) COLLATE public.nocase,
    wms_item_sl_serno character varying(112) COLLATE public.nocase,
    wms_item_thu_serno character varying(112) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);