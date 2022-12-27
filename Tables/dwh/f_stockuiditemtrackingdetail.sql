CREATE TABLE dwh.f_stockuiditemtrackingdetail (
    stk_itm_dtl_key bigint NOT NULL,
    stk_itm_dtl_loc_key bigint NOT NULL,
    stk_itm_dtl_itm_hdr_key bigint NOT NULL,
    stk_itm_dtl_customer_key bigint NOT NULL,
    stk_itm_dtl_date_key bigint NOT NULL,
    stk_itm_dtl_thu_key bigint NOT NULL,
    stk_ou integer,
    stk_location character varying(20) COLLATE public.nocase,
    stk_item character varying(80) COLLATE public.nocase,
    stk_customer character varying(40) COLLATE public.nocase,
    stk_date timestamp without time zone,
    stk_uid_serial_no character varying(60) COLLATE public.nocase,
    stk_lot_no character varying(60) COLLATE public.nocase,
    stk_su character varying(20) COLLATE public.nocase,
    stk_thu_id character varying(80) COLLATE public.nocase,
    stk_thu_serial_no character varying(60) COLLATE public.nocase,
    stk_opn_bal numeric(20,2),
    stk_received numeric(20,2),
    stk_issued numeric(20,2),
    stk_cls_bal numeric(20,2),
    stk_write_off_qty numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_stockuiditemtrackingdetail ALTER COLUMN stk_itm_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_stockuiditemtrackingdetail_stk_itm_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_pkey PRIMARY KEY (stk_itm_dtl_key);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_ukey UNIQUE (stk_ou, stk_location, stk_item, stk_customer, stk_date, stk_uid_serial_no, stk_lot_no);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_stk_itm_dtl_customer_key_fkey FOREIGN KEY (stk_itm_dtl_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_stk_itm_dtl_date_key_fkey FOREIGN KEY (stk_itm_dtl_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_stk_itm_dtl_itm_hdr_key_fkey FOREIGN KEY (stk_itm_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_stk_itm_dtl_loc_key_fkey FOREIGN KEY (stk_itm_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_stk_itm_dtl_thu_key_fkey FOREIGN KEY (stk_itm_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

CREATE INDEX f_stockuiditemtrackingdetail_key_idx ON dwh.f_stockuiditemtrackingdetail USING btree (stk_itm_dtl_loc_key, stk_itm_dtl_itm_hdr_key, stk_itm_dtl_customer_key, stk_itm_dtl_date_key, stk_itm_dtl_thu_key);