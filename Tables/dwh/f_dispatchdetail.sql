CREATE TABLE dwh.f_dispatchdetail (
    dispatch_dtl_key bigint NOT NULL,
    dispatch_hdr_key bigint,
    dispatch_dtl_loc_key bigint,
    dispatch_dtl_thu_key bigint,
    dispatch_dtl_shp_pt_key bigint,
    dispatch_dtl_customer_key bigint,
    dispatch_loc_code character varying(20) COLLATE public.nocase,
    dispatch_ld_sheet_no character varying(40) COLLATE public.nocase,
    dispatch_ld_sheet_ou integer,
    dispatch_lineno integer,
    dispatch_so_no character varying(40) COLLATE public.nocase,
    dispatch_thu_id character varying(80) COLLATE public.nocase,
    dispatch_ship_point character varying(40) COLLATE public.nocase,
    dispatch_ship_mode character varying(80) COLLATE public.nocase,
    dispatch_pack_exec_no character varying(40) COLLATE public.nocase,
    dispatch_customer character varying(40) COLLATE public.nocase,
    dispatch_thu_desc character varying(510) COLLATE public.nocase,
    dispatch_thu_class character varying(80) COLLATE public.nocase,
    dispatch_thu_sr_no character varying(60) COLLATE public.nocase,
    dispatch_su character varying(20) COLLATE public.nocase,
    dispatch_exec_stage character varying(50) COLLATE public.nocase,
    dispatch_uid_serial_no character varying(60) COLLATE public.nocase,
    dispatch_thu_weight numeric(25,2),
    dispatch_thu_wt_uom character varying(20) COLLATE public.nocase,
    dispatch_length_ml numeric(25,2),
    dispatch_height_ml numeric(25,2),
    dispatch_breadth_ml numeric(25,2),
    dispatch_thu_sp_ml character varying(80) COLLATE public.nocase,
    dispatch_uom_ml character varying(20) COLLATE public.nocase,
    dispatch_vol_ml character varying(20) COLLATE public.nocase,
    dispatch_vol_uom_ml numeric(25,2),
    dispatch_outbound_no character varying(40) COLLATE public.nocase,
    dispatch_reasoncode_ml character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_dispatchdetail ALTER COLUMN dispatch_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_dispatchdetail_dispatch_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_pkey PRIMARY KEY (dispatch_dtl_key);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_ukey UNIQUE (dispatch_loc_code, dispatch_ld_sheet_no, dispatch_ld_sheet_ou, dispatch_lineno);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_dispatch_dtl_customer_key_fkey FOREIGN KEY (dispatch_dtl_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_dispatch_dtl_loc_key_fkey FOREIGN KEY (dispatch_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_dispatch_dtl_shp_pt_key_fkey FOREIGN KEY (dispatch_dtl_shp_pt_key) REFERENCES dwh.d_shippingpoint(shp_pt_key);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_dispatch_dtl_thu_key_fkey FOREIGN KEY (dispatch_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_dispatch_hdr_key_fkey FOREIGN KEY (dispatch_hdr_key) REFERENCES dwh.f_dispatchheader(dispatch_hdr_key);

CREATE INDEX f_dispatchdetail_key_idx ON dwh.f_dispatchdetail USING btree (dispatch_hdr_key, dispatch_dtl_loc_key, dispatch_dtl_thu_key, dispatch_dtl_shp_pt_key, dispatch_dtl_customer_key);