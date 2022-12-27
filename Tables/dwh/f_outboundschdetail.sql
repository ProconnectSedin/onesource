CREATE TABLE dwh.f_outboundschdetail (
    obd_sdl_key bigint NOT NULL,
    obh_hr_key bigint NOT NULL,
    oub_loc_key bigint NOT NULL,
    oub_itm_key bigint NOT NULL,
    oub_sch_loc_code character varying(20) COLLATE public.nocase,
    oub_sch_ou integer,
    oub_outbound_ord character varying(40) COLLATE public.nocase,
    oub_sch_lineno integer,
    oub_sch_item_code character varying(80) COLLATE public.nocase,
    oub_item_lineno integer,
    oub_sch_order_qty numeric(20,2),
    oub_sch_masteruom character varying(20) COLLATE public.nocase,
    oub_sch_deliverydate timestamp without time zone,
    oub_sch_serfrom timestamp without time zone,
    oub_sch_serto timestamp without time zone,
    oub_sch_plan_gd_iss_dt timestamp without time zone,
    oub_sch_plan_gd_iss_time timestamp without time zone,
    oub_sch_operation_status character varying(20) COLLATE public.nocase,
    oub_sch_picked_qty numeric(20,2),
    oub_sch_packed_qty numeric(20,2),
    oub_sch_masteruomqty_ml numeric(20,2),
    oub_sch_orderuom_ml character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_outboundschdetail ALTER COLUMN obd_sdl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_outboundschdetail_obd_sdl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_outboundschdetail
    ADD CONSTRAINT f_outboundschdetail_pkey PRIMARY KEY (obd_sdl_key);

ALTER TABLE ONLY dwh.f_outboundschdetail
    ADD CONSTRAINT f_outboundschdetail_ukey UNIQUE (oub_sch_loc_code, oub_outbound_ord, oub_sch_lineno, oub_item_lineno, oub_sch_ou);

ALTER TABLE ONLY dwh.f_outboundschdetail
    ADD CONSTRAINT f_outboundschdetail_oub_item_key_fkey FOREIGN KEY (oub_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_outboundschdetail
    ADD CONSTRAINT f_outboundschdetail_oub_loc_key_fkey FOREIGN KEY (oub_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_outboundschdetail_key_idx ON dwh.f_outboundschdetail USING btree (oub_loc_key, oub_itm_key);

CREATE INDEX f_outboundschdetail_key_idx1 ON dwh.f_outboundschdetail USING btree (oub_sch_ou, oub_sch_loc_code, oub_outbound_ord, oub_sch_lineno, oub_item_lineno);

CREATE INDEX f_outboundschdetail_key_idx2 ON dwh.f_outboundschdetail USING btree (oub_sch_ou, oub_sch_loc_code, oub_outbound_ord);