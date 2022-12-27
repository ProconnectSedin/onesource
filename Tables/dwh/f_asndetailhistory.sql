CREATE TABLE dwh.f_asndetailhistory (
    asn_dtl_hst_key bigint NOT NULL,
    asn_hdr_hst_key bigint NOT NULL,
    asn_dtl_hst_loc_key bigint NOT NULL,
    asn_dtl_hst_itm_hdr_key bigint NOT NULL,
    asn_dtl_hst_thu_key bigint NOT NULL,
    asn_ou integer,
    asn_location character varying(20) COLLATE public.nocase,
    asn_no character varying(40) COLLATE public.nocase,
    asn_amendno integer,
    asn_lineno integer,
    asn_itm_code character varying(80) COLLATE public.nocase,
    asn_qty numeric(25,2),
    asn_batch_no character varying(60) COLLATE public.nocase,
    asn_srl_no character varying(60) COLLATE public.nocase,
    asn_exp_date timestamp without time zone,
    asn_thu_id character varying(80) COLLATE public.nocase,
    asn_thu_desc character varying(510) COLLATE public.nocase,
    asn_thu_qty numeric(25,2),
    po_lineno integer,
    asn_rem character varying(510) COLLATE public.nocase,
    asn_itm_height numeric(25,2),
    asn_itm_volume numeric(25,2),
    asn_itm_weight numeric(25,2),
    asn_outboundorder_qty numeric(25,2),
    asn_bestbeforedate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_asndetailhistory ALTER COLUMN asn_dtl_hst_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_asndetailhistory_asn_dtl_hst_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_asndetailhistory
    ADD CONSTRAINT f_asndetailhistory_pkey PRIMARY KEY (asn_dtl_hst_key);

ALTER TABLE ONLY dwh.f_asndetailhistory
    ADD CONSTRAINT f_asndetailhistory_ukey UNIQUE (asn_ou, asn_location, asn_no, asn_amendno, asn_lineno);

ALTER TABLE ONLY dwh.f_asndetailhistory
    ADD CONSTRAINT f_asndetailhistory_asn_dtl_hst_itm_hdr_key_fkey FOREIGN KEY (asn_dtl_hst_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_asndetailhistory
    ADD CONSTRAINT f_asndetailhistory_asn_dtl_hst_loc_key_fkey FOREIGN KEY (asn_dtl_hst_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_asndetailhistory
    ADD CONSTRAINT f_asndetailhistory_asn_dtl_hst_thu_key_fkey FOREIGN KEY (asn_dtl_hst_thu_key) REFERENCES dwh.d_thu(thu_key);

CREATE INDEX f_asndetailhistory_key_idx ON dwh.f_asndetailhistory USING btree (asn_hdr_hst_key, asn_dtl_hst_loc_key, asn_dtl_hst_itm_hdr_key, asn_dtl_hst_thu_key);

CREATE INDEX f_asndetailhistory_key_idx1 ON dwh.f_asndetailhistory USING btree (asn_ou, asn_location, asn_no, asn_amendno, asn_lineno);

CREATE INDEX f_asndetailhistory_key_idx2 ON dwh.f_asndetailhistory USING btree (asn_ou, asn_location, asn_no, asn_amendno);