CREATE TABLE dwh.f_stockbinhistorydetail (
    stock_bin_key bigint NOT NULL,
    stock_loc_key bigint NOT NULL,
    stock_thu_key bigint NOT NULL,
    stock_item_key bigint NOT NULL,
    stock_cust_key bigint NOT NULL,
    stock_ou integer,
    stock_date timestamp without time zone,
    stock_location character varying(20) COLLATE public.nocase,
    stock_zone character varying(20) COLLATE public.nocase,
    stock_bin character varying(20) COLLATE public.nocase,
    stock_bin_type character varying(40) COLLATE public.nocase,
    stock_customer character varying(40) COLLATE public.nocase,
    stock_item character varying(80) COLLATE public.nocase,
    stock_opening_bal numeric(13,2),
    stock_in_qty numeric(13,2),
    stock_out_qty numeric(13,2),
    stock_bin_qty numeric(13,2),
    stock_thu_id character varying(80) COLLATE public.nocase,
    stock_su_opening_bal numeric(13,2),
    stock_su_count_qty_in numeric(13,2),
    stock_su_count_qty_out numeric(13,2),
    stock_su_count_qty_bal numeric(13,2),
    stock_su character varying(20) COLLATE public.nocase,
    stock_thu_opening_bal numeric(13,2),
    stock_thu_count_qty_in numeric(13,2),
    stock_thu_count_qty_out numeric(13,2),
    stock_thu_count_qty_bal numeric(13,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    bin_dtl_key bigint
);

ALTER TABLE dwh.f_stockbinhistorydetail ALTER COLUMN stock_bin_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_stockbinhistorydetail_stock_bin_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_stockbinhistorydetail
    ADD CONSTRAINT f_stockbinhistorydetail_pkey PRIMARY KEY (stock_bin_key);

ALTER TABLE ONLY dwh.f_stockbinhistorydetail
    ADD CONSTRAINT f_stockbinhistorydetail_ukey UNIQUE (stock_ou, stock_date, stock_location, stock_zone, stock_bin, stock_item, stock_thu_id, stock_su);

ALTER TABLE ONLY dwh.f_stockbinhistorydetail
    ADD CONSTRAINT f_stockbinhistorydetail_stock_cust_key_fkey FOREIGN KEY (stock_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_stockbinhistorydetail
    ADD CONSTRAINT f_stockbinhistorydetail_stock_item_key_fkey FOREIGN KEY (stock_item_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_stockbinhistorydetail
    ADD CONSTRAINT f_stockbinhistorydetail_stock_loc_key_fkey FOREIGN KEY (stock_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_stockbinhistorydetail
    ADD CONSTRAINT f_stockbinhistorydetail_stock_thu_key_fkey FOREIGN KEY (stock_thu_key) REFERENCES dwh.d_thu(thu_key);

CREATE INDEX f_stockbinhistorydetail_key_idx ON dwh.f_stockbinhistorydetail USING btree (stock_loc_key, stock_thu_key, stock_item_key, stock_cust_key);

CREATE INDEX f_stockbinhistorydetail_key_idx1 ON dwh.f_stockbinhistorydetail USING btree (stock_ou, stock_date, stock_location, stock_zone, stock_bin, stock_item, stock_thu_id, stock_su);

CREATE INDEX f_stockbinhistorydetail_key_idx2 ON dwh.f_stockbinhistorydetail USING btree (stock_ou, stock_bin, stock_location, stock_zone, stock_bin_type);

CREATE INDEX f_stockbinhistorydetail_key_idx3 ON dwh.f_stockbinhistorydetail USING btree (bin_dtl_key);