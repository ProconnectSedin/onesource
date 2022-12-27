CREATE TABLE dwh.f_binplandetails (
    bin_plan_key bigint NOT NULL,
    bin_hdr_key bigint NOT NULL,
    bin_loc_dl_key bigint NOT NULL,
    bin_loc_code character varying(20) COLLATE public.nocase,
    bin_pln_no character varying(40) COLLATE public.nocase,
    bin_pln_lineno integer,
    bin_pln_ou integer,
    bin_item character varying(80) COLLATE public.nocase,
    bin_item_batch_no character varying(60) COLLATE public.nocase,
    bin_src_bin character varying(20) COLLATE public.nocase,
    bin_src_zone character varying(20) COLLATE public.nocase,
    bin_su character varying(20) COLLATE public.nocase,
    bin_su_qty numeric(13,2),
    bin_avial_qty numeric(13,2),
    bin_trn_out_qty numeric(13,2),
    bin_tar_bin character varying(20) COLLATE public.nocase,
    bin_tar_zone character varying(20) COLLATE public.nocase,
    bin_lot_no character varying(60) COLLATE public.nocase,
    bin_su_type character varying(20) COLLATE public.nocase,
    bin_su_slno character varying(60) COLLATE public.nocase,
    bin_thu_typ character varying(20) COLLATE public.nocase,
    bin_thu_id character varying(80) COLLATE public.nocase,
    bin_src_staging_id character varying(40) COLLATE public.nocase,
    bin_trgt_staging_id character varying(40) COLLATE public.nocase,
    bin_stk_line_no integer,
    bin_stk_status character varying(20) COLLATE public.nocase,
    bin_status character varying(510) COLLATE public.nocase,
    bin_src_status character varying(20) COLLATE public.nocase,
    bin_from_thu_sl_no character varying(60) COLLATE public.nocase,
    bin_target_thu_sl_no character varying(60) COLLATE public.nocase,
    bin_pal_status character varying(80) COLLATE public.nocase,
    bin_repl_alloc_ln_no integer,
    bin_repl_doc_line_no integer,
    bin_plan_rsn_code character varying(80) COLLATE public.nocase,
    bin_pln_itm_attr1 character varying(100) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_binplandetails ALTER COLUMN bin_plan_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_binplandetails_bin_plan_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_binplandetails
    ADD CONSTRAINT f_binplandetails_pkey PRIMARY KEY (bin_plan_key);

ALTER TABLE ONLY dwh.f_binplandetails
    ADD CONSTRAINT f_binplandetails_ukey UNIQUE (bin_loc_code, bin_pln_no, bin_pln_lineno, bin_pln_ou);

ALTER TABLE ONLY dwh.f_binplandetails
    ADD CONSTRAINT f_binplandetails_bin_hdr_key_fkey FOREIGN KEY (bin_hdr_key) REFERENCES dwh.f_binplanheader(bin_hdr_key);

ALTER TABLE ONLY dwh.f_binplandetails
    ADD CONSTRAINT f_binplandetails_bin_loc_dl_key_fkey FOREIGN KEY (bin_loc_dl_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_binplandetails_key_idx ON dwh.f_binplandetails USING btree (bin_loc_dl_key);

CREATE INDEX f_binplandetails_key_idx1 ON dwh.f_binplandetails USING btree (bin_loc_code, bin_pln_no, bin_pln_lineno, bin_pln_ou);