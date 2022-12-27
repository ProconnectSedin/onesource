CREATE TABLE raw.raw_wms_inbound_sch_item_detail_h (
    raw_id bigint NOT NULL,
    wms_inb_loc_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_inb_orderno character varying(1020) NOT NULL COLLATE public.nocase,
    wms_inb_lineno integer NOT NULL,
    wms_inb_ou integer NOT NULL,
    wms_inb_amendno integer NOT NULL,
    wms_inb_item_lineno integer NOT NULL,
    wms_inb_item_code character varying(128) COLLATE public.nocase,
    wms_inb_schedule_qty numeric,
    wms_inb_receipt_date timestamp without time zone,
    wms_inb_item_inst character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_inbound_sch_item_detail_h ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_inbound_sch_item_detail_h_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_inbound_sch_item_detail_h
    ADD CONSTRAINT raw_wms_inbound_sch_item_detail_h_pkey PRIMARY KEY (raw_id);