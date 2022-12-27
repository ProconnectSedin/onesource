CREATE TABLE dwh.f_binexecitemdetail (
    bin_itm_dtl_key bigint NOT NULL,
    bin_hdr_key bigint NOT NULL,
    bin_loc_key bigint NOT NULL,
    bin_itm_hdr_key bigint NOT NULL,
    bin_thu_key bigint NOT NULL,
    bin_loc_code character varying(20) COLLATE public.nocase,
    bin_exec_no character varying(40) COLLATE public.nocase,
    bin_exec_lineno integer,
    bin_ref_lineno integer,
    bin_exec_ou integer,
    bin_item character varying(80) COLLATE public.nocase,
    bin_src_bin character varying(20) COLLATE public.nocase,
    bin_src_zone character varying(20) COLLATE public.nocase,
    bin_src_staging_id character varying(40) COLLATE public.nocase,
    bin_stk_avial_qty numeric(20,2),
    bin_trn_out_qty numeric(20,2),
    bin_tar_bin character varying(20) COLLATE public.nocase,
    bin_tar_zone character varying(20) COLLATE public.nocase,
    bin_trgt_staging_id character varying(40) COLLATE public.nocase,
    bin_lot_no character varying(60) COLLATE public.nocase,
    bin_item_sr_no character varying(60) COLLATE public.nocase,
    bin_item_batch_no character varying(60) COLLATE public.nocase,
    bin_su_slno character varying(60) COLLATE public.nocase,
    bin_su_type character varying(20) COLLATE public.nocase,
    bin_stk_line_no integer,
    bin_stk_status character varying(20) COLLATE public.nocase,
    bin_src_status character varying(20) COLLATE public.nocase,
    bin_from_thu_sl_no character varying(60) COLLATE public.nocase,
    bin_target_thu_sl_no character varying(60) COLLATE public.nocase,
    bin_su character varying(20) COLLATE public.nocase,
    bin_thu_id character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_binexecitemdetail ALTER COLUMN bin_itm_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_binexecitemdetail_bin_itm_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_binexecitemdetail
    ADD CONSTRAINT f_binexecitemdetail_pkey PRIMARY KEY (bin_itm_dtl_key);

ALTER TABLE ONLY dwh.f_binexecitemdetail
    ADD CONSTRAINT f_binexecitemdetail_ukey UNIQUE (bin_exec_no, bin_ref_lineno, bin_exec_lineno, bin_exec_ou, bin_loc_code);

ALTER TABLE ONLY dwh.f_binexecitemdetail
    ADD CONSTRAINT f_binexecitemdetail_bin_hdr_key_fkey FOREIGN KEY (bin_hdr_key) REFERENCES dwh.f_binexechdr(bin_hdr_key);

ALTER TABLE ONLY dwh.f_binexecitemdetail
    ADD CONSTRAINT f_binexecitemdetail_bin_itm_hdr_key_fkey FOREIGN KEY (bin_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_binexecitemdetail
    ADD CONSTRAINT f_binexecitemdetail_bin_loc_key_fkey FOREIGN KEY (bin_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_binexecitemdetail
    ADD CONSTRAINT f_binexecitemdetail_bin_thu_key_fkey FOREIGN KEY (bin_thu_key) REFERENCES dwh.d_thu(thu_key);

CREATE INDEX f_binexecitemdetail_key_idx ON dwh.f_binexecitemdetail USING btree (bin_hdr_key, bin_loc_key, bin_itm_hdr_key, bin_thu_key);