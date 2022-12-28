CREATE TABLE dwh.f_purchasereceiptheader (
    rcgh_receipt_key bigint NOT NULL,
    rcgh_date_key bigint NOT NULL,
    rcgh_ouinstid integer,
    rcgh_receipt_no character varying(40) COLLATE public.nocase,
    rcgh_num_type_no character varying(20) COLLATE public.nocase,
    rcgh_wh_no character varying(20) COLLATE public.nocase,
    rcgh_ref_doc_no character varying(40) COLLATE public.nocase,
    rcgh_ref_doc_type character varying(20) COLLATE public.nocase,
    rcgh_po_no character varying(40) COLLATE public.nocase,
    rcgh_receipt_date timestamp without time zone,
    rcgh_purchase_point integer,
    rcgh_posting_fb character varying(40) COLLATE public.nocase,
    rcgh_status character varying(10) COLLATE public.nocase,
    rcgh_created_by character varying(60) COLLATE public.nocase,
    rcgh_created_date timestamp without time zone,
    rcgh_modified_by character varying(60) COLLATE public.nocase,
    rcgh_modified_date timestamp without time zone,
    rcgh_timestamp integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_purchasereceiptheader ALTER COLUMN rcgh_receipt_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_purchasereceiptheader_rcgh_receipt_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_purchasereceiptheader
    ADD CONSTRAINT f_purchasereceiptheader_pkey PRIMARY KEY (rcgh_receipt_key);

ALTER TABLE ONLY dwh.f_purchasereceiptheader
    ADD CONSTRAINT f_purchasereceiptheader_ukey UNIQUE (rcgh_ouinstid, rcgh_receipt_no);

ALTER TABLE ONLY dwh.f_purchasereceiptheader
    ADD CONSTRAINT f_purchasereceiptheader_rcgh_date_key_fkey FOREIGN KEY (rcgh_date_key) REFERENCES dwh.d_date(datekey);

CREATE INDEX f_purchasereceiptheader_key_idx ON dwh.f_purchasereceiptheader USING btree (rcgh_date_key);

CREATE INDEX f_purchasereceiptheader_key_idx1 ON dwh.f_purchasereceiptheader USING btree (rcgh_ouinstid, rcgh_receipt_no);