CREATE TABLE raw.raw_wms_inbound_item_detail_h (
    raw_id bigint NOT NULL,
    wms_inb_loc_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_inb_orderno character varying(1020) NOT NULL COLLATE public.nocase,
    wms_inb_lineno integer NOT NULL,
    wms_inb_ou integer NOT NULL,
    wms_inb_amendno integer NOT NULL,
    wms_inb_item_code character varying(128) COLLATE public.nocase,
    wms_inb_order_qty numeric,
    wms_inb_alt_uom character varying(40) COLLATE public.nocase,
    wms_inb_sch_type character varying(1020) COLLATE public.nocase,
    wms_inb_receipt_date timestamp without time zone,
    wms_inb_item_inst character varying(1020) COLLATE public.nocase,
    wms_inb_supp_code character varying(64) COLLATE public.nocase,
    wms_inb_addressid character varying(24) COLLATE public.nocase,
    wms_inb_balqty numeric,
    wms_inb_linestatus character varying(1020) COLLATE public.nocase,
    wms_inb_recdqty numeric,
    wms_inb_accpdqty numeric,
    wms_inb_returnedqty numeric,
    wms_inb_itm_grrejdqty numeric,
    wms_inb_itm_grmovdqty numeric,
    wms_inb_operation_status character varying(32) COLLATE public.nocase,
    wms_inb_cust_item_code character varying(128) COLLATE public.nocase,
    wms_inb_master_uom_qty numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_inbound_item_detail_h ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_inbound_item_detail_h_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_inbound_item_detail_h
    ADD CONSTRAINT raw_wms_inbound_item_detail_h_pkey PRIMARY KEY (raw_id);