CREATE TABLE dwh.f_stockuidtrackingdetail (
    stk_trc_dtl_key bigint NOT NULL,
    stk_trc_dtl_loc_key bigint NOT NULL,
    stk_trc_dtl_zone_key bigint NOT NULL,
    stk_trc_dtl_bin_type_key bigint NOT NULL,
    stk_trc_dtl_customer_key bigint NOT NULL,
    stk_trc_dtl_thu_key bigint NOT NULL,
    stk_ou integer,
    stk_location character varying(20) COLLATE public.nocase,
    stk_zone character varying(20) COLLATE public.nocase,
    stk_bin character varying(20) COLLATE public.nocase,
    stk_bin_type character varying(40) COLLATE public.nocase,
    stk_staging_id character varying(40) COLLATE public.nocase,
    stk_stage character varying(80) COLLATE public.nocase,
    stk_customer character varying(40) COLLATE public.nocase,
    stk_uid_serial_no character varying(60) COLLATE public.nocase,
    stk_thu_id character varying(80) COLLATE public.nocase,
    stk_su character varying(20) COLLATE public.nocase,
    stk_from_date timestamp without time zone,
    stk_to_date timestamp without time zone,
    stk_from_tran_type character varying(50) COLLATE public.nocase,
    stk_to_tran_type character varying(50) COLLATE public.nocase,
    stk_from_tran_no character varying(40) COLLATE public.nocase,
    stk_to_tran_no character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_stockuidtrackingdetail ALTER COLUMN stk_trc_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_stockuidtrackingdetail_stk_trc_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_pkey PRIMARY KEY (stk_trc_dtl_key);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_ukey UNIQUE (stk_location, stk_zone, stk_bin, stk_bin_type, stk_staging_id, stk_stage, stk_customer, stk_uid_serial_no, stk_thu_id, stk_su, stk_from_date);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_stk_trc_dtl_bin_type_key_fkey FOREIGN KEY (stk_trc_dtl_bin_type_key) REFERENCES dwh.d_bintypes(bin_typ_key);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_stk_trc_dtl_customer_key_fkey FOREIGN KEY (stk_trc_dtl_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_stk_trc_dtl_loc_key_fkey FOREIGN KEY (stk_trc_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_stk_trc_dtl_thu_key_fkey FOREIGN KEY (stk_trc_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_stk_trc_dtl_zone_key_fkey FOREIGN KEY (stk_trc_dtl_zone_key) REFERENCES dwh.d_zone(zone_key);

CREATE INDEX f_stockuidtrackingdetail_key_idx ON dwh.f_stockuidtrackingdetail USING btree (stk_trc_dtl_loc_key, stk_trc_dtl_zone_key, stk_trc_dtl_bin_type_key, stk_trc_dtl_customer_key, stk_trc_dtl_thu_key);