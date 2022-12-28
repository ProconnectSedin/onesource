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

ALTER TABLE dwh.f_inboundscheduleitemdetail ALTER COLUMN inb_sl_itm_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_inboundscheduleitemdetail_inb_sl_itm_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_inboundscheduleitemdetail
    ADD CONSTRAINT f_inboundscheduleitemdetail_pkey PRIMARY KEY (inb_sl_itm_dtl_key);

ALTER TABLE ONLY dwh.f_inboundscheduleitemdetail
    ADD CONSTRAINT f_inboundscheduleitemdetail_ukey UNIQUE (inb_loc_code, inb_orderno, inb_lineno, inb_ou);

ALTER TABLE ONLY dwh.f_inboundscheduleitemdetail
    ADD CONSTRAINT f_inboundscheduleitemdetail_inb_hdr_key_fkey FOREIGN KEY (inb_hdr_key) REFERENCES dwh.f_inboundheader(inb_hdr_key);

ALTER TABLE ONLY dwh.f_inboundscheduleitemdetail
    ADD CONSTRAINT f_inboundscheduleitemdetail_inb_itm_key_fkey FOREIGN KEY (inb_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_inboundscheduleitemdetail
    ADD CONSTRAINT f_inboundscheduleitemdetail_inb_loc_key_fkey FOREIGN KEY (inb_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_inboundscheduleitemdetail_key_idx ON dwh.f_inboundscheduleitemdetail USING btree (inb_itm_key, inb_loc_key);

CREATE INDEX f_inboundscheduleitemdetail_key_idx1 ON dwh.f_inboundscheduleitemdetail USING btree (inb_loc_code, inb_orderno, inb_lineno, inb_ou);