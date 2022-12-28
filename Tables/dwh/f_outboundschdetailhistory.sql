CREATE TABLE dwh.f_outboundschdetailhistory (
    obd_sdl_his_key bigint NOT NULL,
    obh_hr_his_key bigint NOT NULL,
    oub_loc_key bigint NOT NULL,
    oub_itm_key bigint NOT NULL,
    oub_sch_loc_code character varying(20) COLLATE public.nocase,
    oub_sch_ou integer,
    oub_outbound_ord character varying(40) COLLATE public.nocase,
    oub_sch_amendno integer,
    oub_sch_lineno integer,
    oub_sch_item_code character varying(80) COLLATE public.nocase,
    oub_item_lineno integer,
    oub_sch_order_qty numeric(25,2),
    oub_sch_masteruom character varying(20) COLLATE public.nocase,
    oub_sch_deliverydate timestamp without time zone,
    oub_sch_serfrom timestamp without time zone,
    oub_sch_serto timestamp without time zone,
    oub_sch_plan_gd_iss_dt timestamp without time zone,
    oub_sch_plan_gd_iss_time timestamp without time zone,
    oub_sch_operation_status character varying(20) COLLATE public.nocase,
    oub_sch_picked_qty numeric(25,2),
    oub_sch_packed_qty numeric(25,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_outboundschdetailhistory ALTER COLUMN obd_sdl_his_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_outboundschdetailhistory_obd_sdl_his_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_outboundschdetailhistory
    ADD CONSTRAINT f_outboundschdetailhistory_pkey PRIMARY KEY (obd_sdl_his_key);

ALTER TABLE ONLY dwh.f_outboundschdetailhistory
    ADD CONSTRAINT f_outboundschdetailhistory_ukey UNIQUE (oub_sch_loc_code, oub_sch_ou, oub_outbound_ord, oub_sch_amendno, oub_sch_lineno, oub_item_lineno);

ALTER TABLE ONLY dwh.f_outboundschdetailhistory
    ADD CONSTRAINT f_outboundschdetailhistory_oub_itm_key_fkey FOREIGN KEY (oub_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_outboundschdetailhistory
    ADD CONSTRAINT f_outboundschdetailhistory_oub_loc_key_fkey FOREIGN KEY (oub_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_outboundschdetailhistory_key_idx1 ON dwh.f_outboundschdetailhistory USING btree (oub_sch_loc_code, oub_sch_ou, oub_outbound_ord, oub_sch_amendno, oub_sch_lineno, oub_item_lineno);

CREATE INDEX f_outboundschdetailhistory_key_idx2 ON dwh.f_outboundschdetailhistory USING btree (oub_loc_key, oub_itm_key);

CREATE INDEX f_outboundschdetailhistory_key_idx3 ON dwh.f_outboundschdetailhistory USING btree (obh_hr_his_key);