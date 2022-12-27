CREATE TABLE stg.stg_wms_outbound_sch_dtl_h (
    wms_oub_sch_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_oub_sch_ou integer NOT NULL,
    wms_oub_outbound_ord character varying(72) NOT NULL COLLATE public.nocase,
    wms_oub_sch_amendno integer NOT NULL,
    wms_oub_sch_lineno integer NOT NULL,
    wms_oub_sch_item_code character varying(128) COLLATE public.nocase,
    wms_oub_item_lineno integer NOT NULL,
    wms_oub_sch_order_qty numeric,
    wms_oub_sch_masteruom character varying(40) COLLATE public.nocase,
    wms_oub_sch_deliverydate timestamp without time zone,
    wms_oub_sch_serfrom timestamp without time zone,
    wms_oub_sch_serto timestamp without time zone,
    wms_oub_sch_plan_gd_iss_dt timestamp without time zone,
    wms_oub_sch_plan_gd_iss_time timestamp without time zone,
    wms_oub_sch_operation_status character varying(32) COLLATE public.nocase,
    wms_oub_sch_picked_qty numeric,
    wms_oub_sch_packed_qty numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

CREATE INDEX stg_wms_outbound_sch_dtl_h_key_idx2 ON stg.stg_wms_outbound_sch_dtl_h USING btree (wms_oub_sch_loc_code, wms_oub_sch_ou, wms_oub_outbound_ord, wms_oub_sch_amendno, wms_oub_sch_lineno, wms_oub_item_lineno);