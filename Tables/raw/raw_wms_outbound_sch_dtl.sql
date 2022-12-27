CREATE TABLE raw.raw_wms_outbound_sch_dtl (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_wms_outbound_sch_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_outbound_sch_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_outbound_sch_dtl
    ADD CONSTRAINT raw_wms_outbound_sch_dtl_pkey PRIMARY KEY (raw_id);