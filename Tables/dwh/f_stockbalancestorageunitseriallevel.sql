CREATE TABLE dwh.f_stockbalancestorageunitseriallevel (
    sbs_blc_usl_key bigint NOT NULL,
    sbl_lot_level_itm_hdr_key bigint NOT NULL,
    sbs_wh_code character varying(20) COLLATE public.nocase,
    sbs_ouinstid integer,
    sbs_item_code character varying(80) COLLATE public.nocase,
    sbs_sr_no character varying(60) COLLATE public.nocase,
    sbs_zone character varying(20) COLLATE public.nocase,
    sbs_bin character varying(20) COLLATE public.nocase,
    sbs_stock_status character varying(80) COLLATE public.nocase,
    sbs_lot_no character varying(60) COLLATE public.nocase,
    sbs_su character varying(20) COLLATE public.nocase,
    sbs_su_type character varying(20) COLLATE public.nocase,
    sbs_thu_id character varying(80) COLLATE public.nocase,
    sbs_su_serial_no character varying(80) COLLATE public.nocase,
    sbs_quantity numeric(132,0),
    sbs_wh_bat_no character varying(60) COLLATE public.nocase,
    sbs_supp_bat_no character varying(60) COLLATE public.nocase,
    sbs_ido_no character varying(40) COLLATE public.nocase,
    sbs_gr_no character varying(40) COLLATE public.nocase,
    sbs_trantype character varying(50) COLLATE public.nocase,
    sbs_thu_serial_no character varying(60) COLLATE public.nocase,
    sbs_customer_serial_no character varying(60) COLLATE public.nocase,
    sbs_3pl_serial_no character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);