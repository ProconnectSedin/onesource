CREATE TABLE dwh.f_outbounditemdetailhistory (
    obd_idl_his_key bigint NOT NULL,
    obh_hr_his_key bigint NOT NULL,
    obd_itm_key bigint NOT NULL,
    obd_loc_key bigint NOT NULL,
    oub_itm_loc_code character varying(20) COLLATE public.nocase,
    oub_itm_ou integer,
    oub_outbound_ord character varying(40) COLLATE public.nocase,
    oub_itm_amendno integer,
    oub_itm_lineno integer,
    oub_item_code character varying(64) COLLATE public.nocase,
    oub_itm_order_qty numeric(13,2),
    oub_itm_sch_type character varying(510) COLLATE public.nocase,
    oub_itm_balqty character varying(132) COLLATE public.nocase,
    oub_itm_issueqty character varying(132) COLLATE public.nocase,
    oub_itm_processqty character varying(132) COLLATE public.nocase,
    oub_itm_masteruom character varying(20) COLLATE public.nocase,
    oub_itm_deliverydate character varying(60) COLLATE public.nocase,
    oub_itm_serfrom character varying(60) COLLATE public.nocase,
    oub_itm_serto character varying(40) COLLATE public.nocase,
    oub_itm_plan_gd_iss_dt character varying(60) COLLATE public.nocase,
    oub_itm_plan_dt_iss character varying(60) COLLATE public.nocase,
    oub_itm_sub_rules character varying(510) COLLATE public.nocase,
    oub_itm_pack_remarks character varying(510) COLLATE public.nocase,
    oub_itm_su character varying(20) COLLATE public.nocase,
    oub_itm_uid_serial_no character varying(60) COLLATE public.nocase,
    oub_itm_cancel character varying(60) COLLATE public.nocase,
    oub_itm_cancel_code character varying(80) COLLATE public.nocase,
    oub_itm_wave_no character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_outbounditemdetailhistory ALTER COLUMN obd_idl_his_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_outbounditemdetailhistory_obd_idl_his_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_outbounditemdetailhistory
    ADD CONSTRAINT f_outbounditemdetailhistory_pkey PRIMARY KEY (obd_idl_his_key);

ALTER TABLE ONLY dwh.f_outbounditemdetailhistory
    ADD CONSTRAINT f_outbounditemdetailhistory_ukey UNIQUE (oub_itm_loc_code, oub_itm_ou, oub_outbound_ord, oub_itm_amendno, oub_itm_lineno);

ALTER TABLE ONLY dwh.f_outbounditemdetailhistory
    ADD CONSTRAINT f_outbounditemdetailhistory_obd_itm_key_fkey FOREIGN KEY (obd_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_outbounditemdetailhistory
    ADD CONSTRAINT f_outbounditemdetailhistory_obd_loc_key_fkey FOREIGN KEY (obd_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_outbounditemdetailhistory_key_idx1 ON dwh.f_outbounditemdetailhistory USING btree (obd_itm_key, obd_loc_key);

CREATE INDEX f_outbounditemdetailhistory_key_idx2 ON dwh.f_outbounditemdetailhistory USING btree (oub_itm_loc_code, oub_itm_ou, oub_outbound_ord, oub_itm_amendno, oub_itm_lineno);

CREATE INDEX f_outbounditemdetailhistory_key_idx3 ON dwh.f_outbounditemdetailhistory USING btree (obh_hr_his_key);