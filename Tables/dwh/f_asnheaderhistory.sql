CREATE TABLE dwh.f_asnheaderhistory (
    asn_hdr_hst_key bigint NOT NULL,
    asn_hdr_hst_loc_key bigint NOT NULL,
    asn_hdr_hst_datekey bigint NOT NULL,
    asn_hdr_hst_customer_key bigint NOT NULL,
    asn_ou integer,
    asn_location character varying(20) COLLATE public.nocase,
    asn_no character varying(40) COLLATE public.nocase,
    asn_amendno integer,
    asn_prefdoc_type character varying(510) COLLATE public.nocase,
    asn_prefdoc_no character varying(40) COLLATE public.nocase,
    asn_prefdoc_date timestamp without time zone,
    asn_date timestamp without time zone,
    asn_status character varying(510) COLLATE public.nocase,
    asn_ib_order character varying(40) COLLATE public.nocase,
    asn_ship_frm character varying(20) COLLATE public.nocase,
    asn_ship_date timestamp without time zone,
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
    asn_shp_grs_wt numeric(25,2),
    asn_shp_wt_uom character varying(20) COLLATE public.nocase,
    asn_shp_pallt integer,
    asn_shp_rem character varying(510) COLLATE public.nocase,
    asn_cnt_no character varying(150) COLLATE public.nocase,
    asn_timestamp integer,
    asn_createdby character varying(60) COLLATE public.nocase,
    asn_created_date timestamp without time zone,
    asn_modifiedby character varying(60) COLLATE public.nocase,
    asn_modified_date timestamp without time zone,
    asn_release_number character varying(510) COLLATE public.nocase,
    asn_block_stage character varying(510) COLLATE public.nocase,
    asn_cust_code character varying(40) COLLATE public.nocase,
    dock_no character varying(510) COLLATE public.nocase,
    asn_reason_code character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_asnheaderhistory ALTER COLUMN asn_hdr_hst_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_asnheaderhistory_asn_hdr_hst_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_asnheaderhistory
    ADD CONSTRAINT f_asnheaderhistory_pkey PRIMARY KEY (asn_hdr_hst_key);

ALTER TABLE ONLY dwh.f_asnheaderhistory
    ADD CONSTRAINT f_asnheaderhistory_ukey UNIQUE (asn_ou, asn_location, asn_no, asn_amendno);

ALTER TABLE ONLY dwh.f_asnheaderhistory
    ADD CONSTRAINT f_asnheaderhistory_asn_hdr_hst_customer_key_fkey FOREIGN KEY (asn_hdr_hst_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_asnheaderhistory
    ADD CONSTRAINT f_asnheaderhistory_asn_hdr_hst_datekey_fkey FOREIGN KEY (asn_hdr_hst_datekey) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_asnheaderhistory
    ADD CONSTRAINT f_asnheaderhistory_asn_hdr_hst_loc_key_fkey FOREIGN KEY (asn_hdr_hst_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_asnheaderhistory_key_idx ON dwh.f_asnheaderhistory USING btree (asn_hdr_hst_loc_key, asn_hdr_hst_datekey, asn_hdr_hst_customer_key);

CREATE INDEX f_asnheaderhistory_key_idx1 ON dwh.f_asnheaderhistory USING btree (asn_ou, asn_location, asn_no, asn_amendno);