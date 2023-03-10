CREATE TABLE stg.stg_wms_outbound_sch_dtl (
    wms_oub_sch_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_oub_sch_ou integer NOT NULL,
    wms_oub_outbound_ord character varying(72) NOT NULL COLLATE public.nocase,
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
    wms_oub_sch_masteruomqty_ml numeric,
    wms_oub_sch_orderuom_ml character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_outbound_sch_dtl
    ADD CONSTRAINT wms_outbound_sch_dtl_pkey PRIMARY KEY (wms_oub_sch_loc_code, wms_oub_sch_ou, wms_oub_outbound_ord, wms_oub_sch_lineno, wms_oub_item_lineno);

CREATE INDEX stg_wms_outbound_sch_dtl_idx ON stg.stg_wms_outbound_sch_dtl USING btree (wms_oub_sch_loc_code, wms_oub_sch_ou);

CREATE INDEX stg_wms_outbound_sch_dtl_idx1 ON stg.stg_wms_outbound_sch_dtl USING btree (wms_oub_sch_item_code, wms_oub_sch_ou);

CREATE INDEX stg_wms_outbound_sch_dtl_idx3 ON stg.stg_wms_outbound_sch_dtl USING btree (wms_oub_sch_ou, wms_oub_sch_loc_code, wms_oub_outbound_ord);

CREATE INDEX stg_wms_outbound_sch_dtl_key_idx2 ON stg.stg_wms_outbound_sch_dtl USING btree (wms_oub_sch_ou, wms_oub_sch_loc_code, wms_oub_outbound_ord, wms_oub_sch_lineno, wms_oub_item_lineno);