CREATE TABLE dwh.f_loadingdetail (
    loading_dtl_key bigint NOT NULL,
    loading_hdr_key bigint NOT NULL,
    loading_dtl_loc_key bigint NOT NULL,
    loading_dtl_thu_key bigint NOT NULL,
    loading_dtl_stg_mas_key bigint NOT NULL,
    loading_dtl_shp_pt_key bigint NOT NULL,
    loading_loc_code character varying(20) COLLATE public.nocase,
    loading_exec_no character varying(40) COLLATE public.nocase,
    loading_exec_ou integer,
    loading_lineno integer,
    loading_thu_id character varying(80) COLLATE public.nocase,
    loading_ship_point character varying(40) COLLATE public.nocase,
    loading_disp_doc_type character varying(20) COLLATE public.nocase,
    loading_disp_doc_no character varying(40) COLLATE public.nocase,
    loading_transfer_doc character varying(510) COLLATE public.nocase,
    loading_thu_desc character varying(510) COLLATE public.nocase,
    loading_thu_class character varying(80) COLLATE public.nocase,
    loading_thu_sr_no character varying(60) COLLATE public.nocase,
    loading_thu_acc character varying(150) COLLATE public.nocase,
    loading_disp_doc_date timestamp without time zone,
    loading_pal_qty numeric(20,2),
    loading_tran_typ character varying(20) COLLATE public.nocase,
    loading_start_date_time timestamp without time zone,
    loading_end_date_time timestamp without time zone,
    loading_so_no character varying(40) COLLATE public.nocase,
    loading_stage character varying(50) COLLATE public.nocase,
    loading_curr_exec character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_loadingdetail ALTER COLUMN loading_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_loadingdetail_loading_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_pkey PRIMARY KEY (loading_dtl_key);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_ukey UNIQUE (loading_loc_code, loading_exec_no, loading_exec_ou, loading_lineno);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_loading_dtl_loc_key_fkey FOREIGN KEY (loading_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_loading_dtl_shp_pt_key_fkey FOREIGN KEY (loading_dtl_shp_pt_key) REFERENCES dwh.d_shippingpoint(shp_pt_key);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_loading_dtl_stg_mas_key_fkey FOREIGN KEY (loading_dtl_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_loading_dtl_thu_key_fkey FOREIGN KEY (loading_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_loading_hdr_key_fkey FOREIGN KEY (loading_hdr_key) REFERENCES dwh.f_loadingheader(loading_hdr_key);

CREATE INDEX f_loadingdetail_key_idx ON dwh.f_loadingdetail USING btree (loading_hdr_key, loading_dtl_loc_key, loading_dtl_stg_mas_key, loading_dtl_thu_key, loading_dtl_shp_pt_key);