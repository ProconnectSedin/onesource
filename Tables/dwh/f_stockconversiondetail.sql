CREATE TABLE dwh.f_stockconversiondetail (
    stk_con_dtl_key bigint NOT NULL,
    stk_con_hdr_key bigint NOT NULL,
    stk_con_dtl_loc_key bigint NOT NULL,
    stk_con_dtl_customer_key bigint NOT NULL,
    stk_con_dtl_itm_hdr_key bigint NOT NULL,
    stk_con_dtl_zone_key bigint NOT NULL,
    stk_con_loc_code character varying(20) COLLATE public.nocase,
    stk_con_proposal_no character varying(40) COLLATE public.nocase,
    stk_con_proposal_ou integer,
    stk_con_lineno integer,
    stk_con_cust_no character varying(40) COLLATE public.nocase,
    stk_con_item_code character varying(80) COLLATE public.nocase,
    stk_con_item_batch_no character varying(40) COLLATE public.nocase,
    stk_con_item_sr_no character varying(60) COLLATE public.nocase,
    stk_con_bin character varying(20) COLLATE public.nocase,
    stk_con_qty numeric(20,2),
    stk_con_from_status character varying(20) COLLATE public.nocase,
    stk_con_to_status character varying(20) COLLATE public.nocase,
    stk_con_from_qty numeric(20,2),
    stk_con_to_qty numeric(20,2),
    stk_con_status character varying(20) COLLATE public.nocase,
    stk_con_remarks character varying(510) COLLATE public.nocase,
    stk_con_su character varying(510) COLLATE public.nocase,
    stk_con_uid_serial_no character varying(510) COLLATE public.nocase,
    stk_con_zone character varying(20) COLLATE public.nocase,
    stk_con_batchno character varying(60) COLLATE public.nocase,
    stk_con_source_staging_id character varying(40) COLLATE public.nocase,
    stk_con_tar_bin character varying(20) COLLATE public.nocase,
    stk_gr_line_no integer,
    stk_gr_exec_no character varying(40) COLLATE public.nocase,
    stk_con_res_code character varying(510) COLLATE public.nocase,
    stk_wrtoff_qlty integer,
    stk_con_stksts character varying(20) COLLATE public.nocase,
    stk_con_from_thu_srno character varying(60) COLLATE public.nocase,
    stk_con_coo character varying(100) COLLATE public.nocase,
    stk_con_inven_type character varying(80) COLLATE public.nocase,
    stk_con_item_atrib1 character varying(100) COLLATE public.nocase,
    stk_con_item_atrib2 character varying(100) COLLATE public.nocase,
    stk_con_item_atrib3 character varying(100) COLLATE public.nocase,
    stk_con_prod_status character varying(80) COLLATE public.nocase,
    stk_con_stk_lineno integer,
    stk_con_curr_stock_qty numeric(20,2),
    stk_con_item_atrib6 character varying(100) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_stockconversiondetail ALTER COLUMN stk_con_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_stockconversiondetail_stk_con_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_pkey PRIMARY KEY (stk_con_dtl_key);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_ukey UNIQUE (stk_con_loc_code, stk_con_proposal_no, stk_con_proposal_ou, stk_con_lineno);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_stk_con_dtl_customer_key_fkey FOREIGN KEY (stk_con_dtl_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_stk_con_dtl_itm_hdr_key_fkey FOREIGN KEY (stk_con_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_stk_con_dtl_loc_key_fkey FOREIGN KEY (stk_con_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_stk_con_dtl_zone_key_fkey FOREIGN KEY (stk_con_dtl_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_stk_con_hdr_key_fkey FOREIGN KEY (stk_con_hdr_key) REFERENCES dwh.f_stockconversionheader(stk_con_hdr_key);

CREATE INDEX f_stockconversiondetail_key_idx ON dwh.f_stockconversiondetail USING btree (stk_con_hdr_key, stk_con_dtl_loc_key, stk_con_dtl_customer_key, stk_con_dtl_itm_hdr_key, stk_con_dtl_zone_key);