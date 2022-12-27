CREATE TABLE dwh.f_stockstoragebalancedetail (
    stk_su_dtl_key bigint NOT NULL,
    stk_su_loc_key bigint NOT NULL,
    stk_su_customer_key bigint NOT NULL,
    stk_ou integer,
    stk_location character varying(20) COLLATE public.nocase,
    stk_customer character varying(40) COLLATE public.nocase,
    stk_date timestamp without time zone,
    stk_su character varying(20) COLLATE public.nocase,
    stk_su_opn_bal numeric(20,2),
    stk_su_received numeric(20,2),
    stk_su_issued numeric(20,2),
    stk_su_cls_bal numeric(20,2),
    stk_su_peak_qty numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_stockstoragebalancedetail ALTER COLUMN stk_su_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_stockstoragebalancedetail_stk_su_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_stockstoragebalancedetail
    ADD CONSTRAINT f_stockstoragebalancedetail_pkey PRIMARY KEY (stk_su_dtl_key);

ALTER TABLE ONLY dwh.f_stockstoragebalancedetail
    ADD CONSTRAINT f_stockstoragebalancedetail_ukey UNIQUE (stk_ou, stk_location, stk_customer, stk_date, stk_su);

ALTER TABLE ONLY dwh.f_stockstoragebalancedetail
    ADD CONSTRAINT f_stockstoragebalancedetail_stk_su_customer_key_fkey FOREIGN KEY (stk_su_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_stockstoragebalancedetail
    ADD CONSTRAINT f_stockstoragebalancedetail_stk_su_loc_key_fkey FOREIGN KEY (stk_su_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_stockstoragebalancedetail_key_idx ON dwh.f_stockstoragebalancedetail USING btree (stk_su_loc_key, stk_su_customer_key);