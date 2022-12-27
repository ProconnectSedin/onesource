CREATE TABLE dwh.f_goodsissuedetails (
    gi_gid_key bigint NOT NULL,
    gi_loc_key bigint NOT NULL,
    gi_no character varying(40) COLLATE public.nocase,
    gi_ou integer,
    gi_status character varying(20) COLLATE public.nocase,
    gi_loc_code character varying(20) COLLATE public.nocase,
    gi_outbound_ord_no character varying(40) COLLATE public.nocase,
    gi_line_no integer,
    gi_date timestamp without time zone,
    gi_execution_no character varying(40) COLLATE public.nocase,
    gi_execution_stage character varying(50) COLLATE public.nocase,
    gi_outbound_date timestamp without time zone,
    gi_customer_id character varying(40) COLLATE public.nocase,
    gi_prim_ref_doc_no character varying(40) COLLATE public.nocase,
    gi_prim_ref_doc_date timestamp without time zone,
    gi_outbound_ord_line_no integer,
    gi_outbound_ord_sch_no integer,
    gi_outbound_ord_item character varying(80) COLLATE public.nocase,
    gi_issue_qty numeric(13,2),
    gi_lot_no character varying(60) COLLATE public.nocase,
    gi_item_serial_no character varying(60) COLLATE public.nocase,
    gi_sup_batch_no character varying(60) COLLATE public.nocase,
    gi_mfg_date timestamp without time zone,
    gi_exp_date timestamp without time zone,
    gi_item_status character varying(20) COLLATE public.nocase,
    gi_su character varying(80) COLLATE public.nocase,
    gi_su_type character varying(20) COLLATE public.nocase,
    gi_su_serial_no character varying(60) COLLATE public.nocase,
    gi_created_date timestamp without time zone,
    gi_created_by character varying(60) COLLATE public.nocase,
    gi_tolerance_qty numeric(13,2),
    gi_stock_status character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_goodsissuedetails ALTER COLUMN gi_gid_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_goodsissuedetails_gi_gid_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_goodsissuedetails
    ADD CONSTRAINT f_goodsissuedetails_pkey PRIMARY KEY (gi_gid_key);

ALTER TABLE ONLY dwh.f_goodsissuedetails
    ADD CONSTRAINT f_goodsissuedetails_ukey UNIQUE (gi_no, gi_ou, gi_loc_code, gi_outbound_ord_no, gi_line_no);

ALTER TABLE ONLY dwh.f_goodsissuedetails
    ADD CONSTRAINT f_goodsissuedetails_gi_loc_key_fkey FOREIGN KEY (gi_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_goodsissuedetails_key_idx ON dwh.f_goodsissuedetails USING btree (gi_loc_key);

CREATE INDEX f_goodsissuedetails_key_idx1 ON dwh.f_goodsissuedetails USING btree (gi_no, gi_ou, gi_loc_code, gi_outbound_ord_no, gi_line_no);