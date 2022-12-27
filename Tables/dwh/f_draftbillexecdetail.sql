CREATE TABLE dwh.f_draftbillexecdetail (
    draft_bill_exec_dtl_key bigint NOT NULL,
    draft_bill_loc_key bigint NOT NULL,
    draft_bill_customer_key bigint NOT NULL,
    draft_bill_thu_key bigint NOT NULL,
    draft_bill_itm_hdr_key bigint NOT NULL,
    draft_bill_stg_mas_key bigint NOT NULL,
    exec_loc_code character varying(20) COLLATE public.nocase,
    exec_ou integer,
    exec_no character varying(40) COLLATE public.nocase,
    exec_stage character varying(50) COLLATE public.nocase,
    exec_line_no integer,
    exec_executed_on timestamp without time zone,
    exec_customer_id character varying(40) COLLATE public.nocase,
    exec_ref_doc_type character varying(20) COLLATE public.nocase,
    exec_ref_doc_no character varying(40) COLLATE public.nocase,
    exec_ref_doc_line_no integer,
    exec_ref_doc_sch_no integer,
    exec_tran_qty numeric(20,2),
    exec_item_lot_no character varying(60) COLLATE public.nocase,
    exec_item_batch_no character varying(60) COLLATE public.nocase,
    exec_item_serial_no character varying(60) COLLATE public.nocase,
    exec_thu_id character varying(80) COLLATE public.nocase,
    exec_thu_ser_no character varying(60) COLLATE public.nocase,
    exec_uid_ser_no character varying(60) COLLATE public.nocase,
    exec_item_code character varying(80) COLLATE public.nocase,
    exec_su character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_draftbillexecdetail ALTER COLUMN draft_bill_exec_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_draftbillexecdetail_draft_bill_exec_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_pkey PRIMARY KEY (draft_bill_exec_dtl_key);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_ukey UNIQUE (exec_loc_code, exec_ou, exec_no, exec_stage, exec_line_no);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_draft_bill_customer_key_fkey FOREIGN KEY (draft_bill_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_draft_bill_itm_hdr_key_fkey FOREIGN KEY (draft_bill_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_draft_bill_loc_key_fkey FOREIGN KEY (draft_bill_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_draft_bill_stg_mas_key_fkey FOREIGN KEY (draft_bill_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_draft_bill_thu_key_fkey FOREIGN KEY (draft_bill_thu_key) REFERENCES dwh.d_thu(thu_key);

CREATE INDEX f_draftbillexecdetail_key_idx ON dwh.f_draftbillexecdetail USING btree (draft_bill_itm_hdr_key, draft_bill_stg_mas_key, draft_bill_thu_key, draft_bill_customer_key, draft_bill_loc_key);

CREATE INDEX f_draftbillexecdetail_key_idx1 ON dwh.f_draftbillexecdetail USING btree (exec_loc_code, exec_ou, exec_no, exec_stage, exec_line_no);