-- Table: click.f_outbounditemdetail

-- DROP TABLE IF EXISTS click.f_outbounditemdetail;

CREATE TABLE IF NOT EXISTS click.f_outbounditemdetail
(
    obd_idl_key bigint NOT NULL,
    obh_hr_key bigint NOT NULL,
    obd_itm_key bigint NOT NULL,
    obd_loc_key bigint NOT NULL,
    oub_itm_loc_code character varying(20) COLLATE public.nocase,
    oub_itm_ou integer,
    oub_outbound_ord character varying(40) COLLATE public.nocase,
    oub_itm_lineno integer,
    oub_item_code character varying(80) COLLATE public.nocase,
    oub_itm_order_qty numeric(20,2),
    oub_itm_sch_type character varying(510) COLLATE public.nocase,
    oub_itm_balqty numeric(20,2),
    oub_itm_issueqty numeric(20,2),
    oub_itm_processqty numeric(20,2),
    oub_itm_masteruom character varying(20) COLLATE public.nocase,
    oub_itm_deliverydate timestamp without time zone,
    oub_itm_plan_gd_iss_dt timestamp without time zone,
    oub_itm_sub_rules character varying(510) COLLATE public.nocase,
    oub_itm_pack_remarks character varying(510) COLLATE public.nocase,
    oub_itm_mas_qty numeric(20,2),
    oub_itm_order_item character varying(20) COLLATE pg_catalog."default",
    oub_itm_lotsl_batchno character varying(60) COLLATE public.nocase,
    oub_itm_cus_srno character varying(140) COLLATE public.nocase,
    oub_itm_refdocno1 character varying(40) COLLATE public.nocase,
    oub_itm_refdocno2 character varying(40) COLLATE public.nocase,
    oub_itm_serialno character varying(60) COLLATE public.nocase,
    oub_itm_thu_id character varying(80) COLLATE public.nocase,
    oub_itm_thu_srno character varying(60) COLLATE public.nocase,
    oub_itm_inst character varying(80) COLLATE public.nocase,
    oub_itm_user_def_1 character varying(510) COLLATE public.nocase,
    oub_itm_user_def_2 numeric(20,2),
    oub_itm_user_def_3 character varying(510) COLLATE public.nocase,
    oub_itm_stock_sts character varying(80) COLLATE public.nocase,
    oub_itm_cust character varying(40) COLLATE public.nocase,
    oub_itm_coo_ml character varying(100) COLLATE public.nocase,
    oub_itm_arribute1 character varying(100) COLLATE public.nocase,
    oub_itm_arribute2 character varying(100) COLLATE public.nocase,
    oub_itm_cancel integer,
    oub_itm_cancel_code character varying(80) COLLATE public.nocase,
    oub_itm_component integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    oub_itm_volume numeric(20,2),
    oub_itm_weight numeric(20,2),
    createddate timestamp(3) without time zone,
    updatedatetime timestamp(3) without time zone,
    CONSTRAINT f_outbounditemdetail_pkey PRIMARY KEY (obd_idl_key),
    CONSTRAINT f_outbounditemdetail_ukey UNIQUE (oub_itm_ou, oub_itm_loc_code, oub_outbound_ord, oub_itm_lineno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_outbounditemdetail
    OWNER to proconnect;