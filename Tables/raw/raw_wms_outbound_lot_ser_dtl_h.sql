CREATE TABLE raw.raw_wms_outbound_lot_ser_dtl_h (
    wms_oub_lotsl_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_oub_lotsl_ou integer NOT NULL,
    wms_oub_outbound_ord character varying(72) NOT NULL COLLATE public.nocase,
    wms_oub_lotsl_lineno integer NOT NULL,
    wms_oub_lotsl_amendno integer NOT NULL,
    wms_oub_item_code character varying(128) COLLATE public.nocase,
    wms_oub_item_lineno integer,
    wms_oub_lotsl_order_qty numeric,
    wms_oub_lotsl_batchno character varying(112) COLLATE public.nocase,
    wms_oub_lotsl_serialno character varying(112) COLLATE public.nocase,
    wms_oub_lotsl_masteruom character varying(40) COLLATE public.nocase,
    wms_oub_refdocno1 character varying(72) COLLATE public.nocase,
    wms_oub_refdocno2 character varying(72) COLLATE public.nocase,
    wms_oub_thu_id character varying(160) COLLATE public.nocase,
    wms_oub_thu_srno character varying(112) COLLATE public.nocase,
    wms_oub_cus_srno character varying(280) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);