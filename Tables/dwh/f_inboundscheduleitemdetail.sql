CREATE TABLE dwh.f_inboundscheduleitemdetail (
    inb_sl_itm_dtl_key bigint NOT NULL,
    inb_hdr_key bigint NOT NULL,
    inb_itm_key bigint NOT NULL,
    inb_loc_key bigint NOT NULL,
    inb_loc_code character varying(80) COLLATE public.nocase,
    inb_orderno character varying(510) COLLATE public.nocase,
    inb_lineno integer,
    inb_ou integer,
    inb_item_lineno integer,
    inb_item_code character varying(80) COLLATE public.nocase,
    inb_schedule_qty numeric(20,2),
    inb_receipt_date timestamp without time zone,
    inb_item_inst character varying(510) COLLATE public.nocase,
    inb_order_uom character varying(20) COLLATE public.nocase,
    inb_mas_uom_qty numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);