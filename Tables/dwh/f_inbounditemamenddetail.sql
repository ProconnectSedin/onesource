CREATE TABLE dwh.f_inbounditemamenddetail (
    inb_itm_dtl_key bigint NOT NULL,
    inb_amh_key bigint NOT NULL,
    inb_itm_key bigint NOT NULL,
    inb_loc_key bigint NOT NULL,
    inb_loc_code character varying(80) COLLATE public.nocase,
    inb_orderno character varying(510) COLLATE public.nocase,
    inb_lineno integer,
    inb_ou integer,
    inb_amendno integer,
    inb_item_code character varying(80) COLLATE public.nocase,
    inb_order_qty numeric(20,2),
    inb_alt_uom character varying(20) COLLATE public.nocase,
    inb_sch_type character varying(510) COLLATE public.nocase,
    inb_receipt_date timestamp without time zone,
    inb_item_inst character varying(510) COLLATE public.nocase,
    inb_supp_code character varying(40) COLLATE public.nocase,
    inb_balqty numeric(20,2),
    inb_linestatus character varying(510) COLLATE public.nocase,
    inb_recdqty numeric(20,2),
    inb_accpdqty numeric(20,2),
    inb_itm_grrejdqty numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);