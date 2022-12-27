CREATE TABLE dwh.f_lottrackingdetail (
    stk_lottrk_dtl_key bigint NOT NULL,
    stk_loc_key bigint NOT NULL,
    stk_item_key bigint NOT NULL,
    stk_customer_key bigint NOT NULL,
    stk_ou integer,
    stk_location character varying(20) COLLATE public.nocase,
    stk_item character varying(80) COLLATE public.nocase,
    stk_customer character varying(40) COLLATE public.nocase,
    stk_date timestamp without time zone,
    stk_lot_no character varying(60) COLLATE public.nocase,
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

ALTER TABLE dwh.f_lottrackingdetail ALTER COLUMN stk_lottrk_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_lottrackingdetail_stk_lottrk_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_lottrackingdetail
    ADD CONSTRAINT f_lottrackingdetail_pkey PRIMARY KEY (stk_lottrk_dtl_key);

ALTER TABLE ONLY dwh.f_lottrackingdetail
    ADD CONSTRAINT f_lottrackingdetail_ukey UNIQUE (stk_ou, stk_location, stk_item, stk_customer, stk_date, stk_lot_no);

ALTER TABLE ONLY dwh.f_lottrackingdetail
    ADD CONSTRAINT f_lottrackingdetail_stk_customer_key_fkey FOREIGN KEY (stk_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_lottrackingdetail
    ADD CONSTRAINT f_lottrackingdetail_stk_item_key_fkey FOREIGN KEY (stk_item_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_lottrackingdetail
    ADD CONSTRAINT f_lottrackingdetail_stk_loc_key_fkey FOREIGN KEY (stk_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_lottrackingdetail_key_idx ON dwh.f_lottrackingdetail USING btree (stk_loc_key, stk_item_key, stk_customer_key);

CREATE INDEX f_lottrackingdetail_key_idx1 ON dwh.f_lottrackingdetail USING btree (stk_ou, stk_location, stk_item, stk_customer, stk_date, stk_lot_no);