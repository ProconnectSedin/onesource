CREATE TABLE dwh.f_binexecdetail (
    bin_exec_dtl_key bigint NOT NULL,
    bin_exec_hdr_key bigint NOT NULL,
    bin_exec_loc_key bigint NOT NULL,
    bin_exec_itm_hdr_key bigint NOT NULL,
    bin_exec_thu_key bigint NOT NULL,
    bin_loc_code character varying(20) COLLATE public.nocase,
    bin_exec_no character varying(40) COLLATE public.nocase,
    bin_exec_ou integer,
    bin_pln_lineno integer,
    bin_pln_no character varying(40) COLLATE public.nocase,
    bin_pln_ou integer,
    bin_item character varying(80) COLLATE public.nocase,
    bin_item_batch_no character varying(60) COLLATE public.nocase,
    bin_item_sr_no character varying(60) COLLATE public.nocase,
    bin_uid character varying(80) COLLATE public.nocase,
    bin_src_bin character varying(20) COLLATE public.nocase,
    bin_src_zone character varying(20) COLLATE public.nocase,
    bin_su character varying(20) COLLATE public.nocase,
    bin_su_qty numeric(20,2),
    bin_avial_qty numeric(20,2),
    bin_trn_out_qty numeric(20,2),
    bin_act_bin character varying(20) COLLATE public.nocase,
    bin_act_zone character varying(20) COLLATE public.nocase,
    bin_tar_zone character varying(20) COLLATE public.nocase,
    bin_tar_bin character varying(20) COLLATE public.nocase,
    bin_act_qty numeric(13,2),
    bin_lot_no character varying(60) COLLATE public.nocase,
    bin_su_slno character varying(60) COLLATE public.nocase,
    bin_uid_slno character varying(60) COLLATE public.nocase,
    bin_thu_typ character varying(20) COLLATE public.nocase,
    bin_thu_id character varying(80) COLLATE public.nocase,
    bin_src_staging_id character varying(40) COLLATE public.nocase,
    bin_trgt_staging_id character varying(40) COLLATE public.nocase,
    bin_stk_line_no integer,
    bin_stk_status character varying(20) COLLATE public.nocase,
    bin_su_type character varying(20) COLLATE public.nocase,
    bin_status character varying(510) COLLATE public.nocase,
    bin_src_status character varying(20) COLLATE public.nocase,
    bin_from_thu_sl_no character varying(60) COLLATE public.nocase,
    bin_target_thu_sl_no character varying(60) COLLATE public.nocase,
    bin_rsn_code character varying(80) COLLATE public.nocase,
    bin_pal_status character varying(80) COLLATE public.nocase,
    bin_repl_alloc_ln_no integer,
    bin_repl_doc_line_no integer,
    bin_item_attr1 character varying(100) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_binexecdetail ALTER COLUMN bin_exec_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_binexecdetail_bin_exec_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_binexecdetail
    ADD CONSTRAINT f_binexecdetail_pkey PRIMARY KEY (bin_exec_dtl_key);

ALTER TABLE ONLY dwh.f_binexecdetail
    ADD CONSTRAINT f_binexecdetail_ukey UNIQUE (bin_loc_code, bin_exec_no, bin_pln_lineno, bin_exec_ou);

ALTER TABLE ONLY dwh.f_binexecdetail
    ADD CONSTRAINT f_binexecdetail_bin_exec_hdr_key_fkey FOREIGN KEY (bin_exec_hdr_key) REFERENCES dwh.f_binexechdr(bin_hdr_key);

ALTER TABLE ONLY dwh.f_binexecdetail
    ADD CONSTRAINT f_binexecdetail_bin_exec_itm_hdr_key_fkey FOREIGN KEY (bin_exec_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_binexecdetail
    ADD CONSTRAINT f_binexecdetail_bin_exec_loc_key_fkey FOREIGN KEY (bin_exec_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_binexecdetail
    ADD CONSTRAINT f_binexecdetail_bin_exec_thu_key_fkey FOREIGN KEY (bin_exec_thu_key) REFERENCES dwh.d_thu(thu_key);

CREATE INDEX f_binexecdetail_key_idx ON dwh.f_binexecdetail USING btree (bin_exec_hdr_key, bin_exec_loc_key, bin_exec_itm_hdr_key, bin_exec_thu_key);