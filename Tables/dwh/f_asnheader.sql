CREATE TABLE dwh.f_asnheader (
    asn_hr_key bigint NOT NULL,
    asn_loc_key bigint NOT NULL,
    asn_date_key bigint NOT NULL,
    asn_cust_key bigint NOT NULL,
    asn_supp_key bigint NOT NULL,
    asn_ou integer,
    asn_location character varying(20) COLLATE public.nocase,
    asn_no character varying(40) COLLATE public.nocase,
    asn_prefdoc_type character varying(510) COLLATE public.nocase,
    asn_prefdoc_no character varying(40) COLLATE public.nocase,
    asn_prefdoc_date timestamp without time zone,
    asn_date timestamp without time zone,
    asn_status character varying(510) COLLATE public.nocase,
    asn_operation_status character varying(50) COLLATE public.nocase,
    asn_ib_order character varying(40) COLLATE public.nocase,
    asn_ship_frm character varying(20) COLLATE public.nocase,
    asn_ship_date timestamp without time zone,
    asn_dlv_loc character varying(20) COLLATE public.nocase,
    asn_dlv_date timestamp without time zone,
    asn_sup_asn_no character varying(40) COLLATE public.nocase,
    asn_sup_asn_date timestamp without time zone,
    asn_sent_by character varying(80) COLLATE public.nocase,
    asn_rem character varying(510) COLLATE public.nocase,
    asn_shp_ref_typ character varying(80) COLLATE public.nocase,
    asn_shp_ref_no character varying(40) COLLATE public.nocase,
    asn_shp_ref_date timestamp without time zone,
    asn_shp_carrier character varying(80) COLLATE public.nocase,
    asn_shp_mode character varying(80) COLLATE public.nocase,
    asn_shp_vh_typ character varying(80) COLLATE public.nocase,
    asn_shp_vh_no character varying(60) COLLATE public.nocase,
    asn_shp_eqp_typ character varying(80) COLLATE public.nocase,
    asn_shp_eqp_no character varying(60) COLLATE public.nocase,
    asn_shp_grs_wt numeric(13,2),
    asn_shp_nt_wt numeric(13,2),
    asn_shp_wt_uom character varying(20) COLLATE public.nocase,
    asn_shp_vol numeric(13,2),
    asn_shp_vol_uom character varying(20) COLLATE public.nocase,
    asn_shp_pallt integer,
    asn_shp_rem character varying(510) COLLATE public.nocase,
    asn_cnt_typ character varying(510) COLLATE public.nocase,
    asn_cnt_no character varying(150) COLLATE public.nocase,
    asn_cnt_qtyp character varying(510) COLLATE public.nocase,
    asn_cnt_qsts character varying(510) COLLATE public.nocase,
    asn_timestamp integer,
    asn_usrdf1 character varying(510) COLLATE public.nocase,
    asn_usrdf2 character varying(510) COLLATE public.nocase,
    asn_usrdf3 character varying(510) COLLATE public.nocase,
    asn_createdby character varying(60) COLLATE public.nocase,
    asn_created_date timestamp without time zone,
    asn_modifiedby character varying(60) COLLATE public.nocase,
    asn_modified_date timestamp without time zone,
    asn_gen_frm character varying(510) COLLATE public.nocase,
    asn_release_date timestamp without time zone,
    asn_release_number character varying(510) COLLATE public.nocase,
    asn_block_stage character varying(510) COLLATE public.nocase,
    asn_amendno integer,
    asn_cust_code character varying(40) COLLATE public.nocase,
    asn_supp_code character varying(40) COLLATE public.nocase,
    asn_quaran_bil_status character varying(20) COLLATE public.nocase,
    dock_no character varying(510) COLLATE public.nocase,
    total_value numeric(13,2),
    asn_gate_no character varying(80) COLLATE public.nocase,
    asn_type character varying(20) COLLATE public.nocase,
    asn_wchboinv_bil_status character varying(20) COLLATE public.nocase,
    asn_adfepasn_bil_status character varying(20) COLLATE public.nocase,
    asn_reason_code character varying(80) COLLATE public.nocase,
    asn_whimchpd_sell_bil_status character varying(50) COLLATE public.nocase,
    asn_wichbain_sell_bil_status character varying(50) COLLATE public.nocase,
    asn_stpcgthu_bil_status character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_asnheader ALTER COLUMN asn_hr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_asnheader_asn_hr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_asnheader
    ADD CONSTRAINT f_asnheader_pkey PRIMARY KEY (asn_hr_key);

ALTER TABLE ONLY dwh.f_asnheader
    ADD CONSTRAINT f_asnheader_ukey UNIQUE (asn_ou, asn_location, asn_no);

ALTER TABLE ONLY dwh.f_asnheader
    ADD CONSTRAINT f_asnheader_asn_cust_key_fkey FOREIGN KEY (asn_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_asnheader
    ADD CONSTRAINT f_asnheader_asn_date_key_fkey FOREIGN KEY (asn_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_asnheader
    ADD CONSTRAINT f_asnheader_asn_loc_key_fkey FOREIGN KEY (asn_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_asnheader
    ADD CONSTRAINT f_asnheader_asn_supp_key_fkey FOREIGN KEY (asn_supp_key) REFERENCES dwh.d_vendor(vendor_key);

CREATE INDEX f_asnheader_key_idx ON dwh.f_asnheader USING btree (asn_loc_key, asn_date_key, asn_cust_key, asn_supp_key);

CREATE INDEX f_asnheader_key_idx1 ON dwh.f_asnheader USING btree (asn_ou, asn_location, asn_no, asn_gate_no);

CREATE INDEX f_asnheader_key_idx2 ON dwh.f_asnheader USING btree (asn_location, asn_ou, asn_no);