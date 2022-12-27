CREATE TABLE dwh.f_outboundlotsrldetail (
    oub_lotsl_loc_key bigint NOT NULL,
    obh_hr_key bigint NOT NULL,
    oub_loc_key bigint NOT NULL,
    oub_itm_key bigint NOT NULL,
    oub_lotsl_loc_code character varying(20) COLLATE public.nocase,
    oub_lotsl_ou integer,
    oub_outbound_ord character varying(40) COLLATE public.nocase,
    oub_lotsl_lineno integer,
    oub_item_code character varying(80) COLLATE public.nocase,
    oub_item_lineno integer,
    oub_lotsl_order_qty numeric(20,2),
    oub_lotsl_batchno character varying(60) COLLATE public.nocase,
    oub_lotsl_serialno character varying(60) COLLATE public.nocase,
    oub_lotsl_masteruom character varying(20) COLLATE public.nocase,
    oub_refdocno1 character varying(40) COLLATE public.nocase,
    oub_refdocno2 character varying(40) COLLATE public.nocase,
    oub_thu_id character varying(80) COLLATE public.nocase,
    oub_thu_srno character varying(60) COLLATE public.nocase,
    oub_cus_srno character varying(140) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_outboundlotsrldetail ALTER COLUMN oub_lotsl_loc_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_outboundlotsrldetail_oub_lotsl_loc_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_outboundlotsrldetail
    ADD CONSTRAINT f_outboundlotsrldetail_pkey PRIMARY KEY (oub_lotsl_loc_key);

ALTER TABLE ONLY dwh.f_outboundlotsrldetail
    ADD CONSTRAINT f_outboundlotsrldetail_ukey UNIQUE (oub_lotsl_loc_code, oub_outbound_ord, oub_lotsl_lineno, oub_lotsl_ou);

ALTER TABLE ONLY dwh.f_outboundlotsrldetail
    ADD CONSTRAINT f_outboundlotsrldetail_oub_item_key_fkey FOREIGN KEY (oub_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_outboundlotsrldetail
    ADD CONSTRAINT f_outboundlotsrldetail_oub_loc_key_fkey FOREIGN KEY (oub_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_outboundlotsrldetail_idx ON dwh.f_outboundlotsrldetail USING btree (oub_lotsl_ou, oub_lotsl_loc_code, oub_outbound_ord);

CREATE INDEX f_outboundlotsrldetail_key_idx ON dwh.f_outboundlotsrldetail USING btree (oub_loc_key, oub_itm_key);

CREATE INDEX f_outboundlotsrldetail_key_idx1 ON dwh.f_outboundlotsrldetail USING btree (oub_lotsl_loc_code, oub_lotsl_ou, oub_outbound_ord, oub_lotsl_lineno);

CREATE INDEX f_outboundlotsrldetail_key_idx2 ON dwh.f_outboundlotsrldetail USING btree (oub_lotsl_ou, oub_lotsl_loc_code, oub_outbound_ord);