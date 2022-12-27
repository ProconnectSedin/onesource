CREATE TABLE stg.stg_wms_outbound_item_detail_h (
    wms_oub_itm_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_oub_itm_ou integer NOT NULL,
    wms_oub_outbound_ord character varying(72) NOT NULL COLLATE public.nocase,
    wms_oub_itm_amendno integer NOT NULL,
    wms_oub_itm_lineno integer NOT NULL,
    wms_oub_item_code character varying(128) COLLATE public.nocase,
    wms_oub_itm_order_qty numeric,
    wms_oub_itm_sch_type character varying(1020) COLLATE public.nocase,
    wms_oub_itm_balqty numeric,
    wms_oub_itm_issueqty numeric,
    wms_oub_itm_processqty numeric,
    wms_oub_itm_masteruom character varying(40) COLLATE public.nocase,
    wms_oub_itm_deliverydate timestamp without time zone,
    wms_oub_itm_serfrom timestamp without time zone,
    wms_oub_itm_serto timestamp without time zone,
    wms_oub_itm_plan_gd_iss_dt timestamp without time zone,
    wms_oub_itm_plan_dt_iss timestamp without time zone,
    wms_oub_itm_sub_rules character varying(1020) COLLATE public.nocase,
    wms_oub_itm_pack_remarks character varying(1020) COLLATE public.nocase,
    wms_oub_itm_su character varying(40) COLLATE public.nocase,
    wms_oub_itm_uid_serial_no character varying(112) COLLATE public.nocase,
    wms_oub_itm_cancel integer,
    wms_oub_itm_cancel_code character varying(160) COLLATE public.nocase,
    wms_oub_itm_wave_no character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

CREATE INDEX stg_wms_outbound_item_detail_h_key_idx2 ON stg.stg_wms_outbound_item_detail_h USING btree (wms_oub_itm_loc_code, wms_oub_itm_ou, wms_oub_outbound_ord, wms_oub_itm_amendno, wms_oub_itm_lineno);