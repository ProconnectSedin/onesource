CREATE TABLE dwh.f_trippodattachmentdetail (
    tpad_dtl_key bigint NOT NULL,
    tpad_trip_hdr_key bigint NOT NULL,
    tpad_ouinstance integer,
    tpad_trip_id character varying(80) COLLATE public.nocase,
    tpad_seqno integer,
    tpad_line_no character varying(300) COLLATE public.nocase,
    tpad_doc_no character varying(80) COLLATE public.nocase,
    tpad_document_code character varying(80) COLLATE public.nocase,
    tpad_attachment_file_name character varying(510) COLLATE public.nocase,
    tpad_attachment character varying(8000) COLLATE public.nocase,
    tpad_remarks character varying(510) COLLATE public.nocase,
    tpad_created_by character varying(60) COLLATE public.nocase,
    tpad_created_date timestamp without time zone,
    tpad_last_updated_by character varying(60) COLLATE public.nocase,
    tpad_last_updated_date timestamp without time zone,
    tpad_timestamp integer,
    tpad_addln_doc_no character varying(80) COLLATE public.nocase,
    tpad_doc_type character varying(80) COLLATE public.nocase,
    tpad_hdn_file_name character varying(510) COLLATE public.nocase,
    tpad_parent_guid character varying(300) COLLATE public.nocase,
    tpad_dispatch_doc_no character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_trippodattachmentdetail ALTER COLUMN tpad_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_trippodattachmentdetail_tpad_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_trippodattachmentdetail
    ADD CONSTRAINT f_trippodattachmentdetail_pkey PRIMARY KEY (tpad_dtl_key);

ALTER TABLE ONLY dwh.f_trippodattachmentdetail
    ADD CONSTRAINT f_trippodattachmentdetail_ukey UNIQUE (tpad_line_no);

ALTER TABLE ONLY dwh.f_trippodattachmentdetail
    ADD CONSTRAINT f_trippodattachmentdetail_tpad_trip_hdr_key_fkey FOREIGN KEY (tpad_trip_hdr_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

CREATE INDEX f_trippodattachmentdetail_key_idx ON dwh.f_trippodattachmentdetail USING btree (tpad_line_no);

CREATE INDEX f_trippodattachmentdetail_key_idx1 ON dwh.f_trippodattachmentdetail USING btree (tpad_trip_hdr_key);

CREATE INDEX f_trippodattachmentdetail_key_idx2 ON dwh.f_trippodattachmentdetail USING btree (tpad_ouinstance, tpad_trip_id, tpad_dispatch_doc_no);

CREATE INDEX f_trippodattachmentdetail_key_idx3 ON dwh.f_trippodattachmentdetail USING btree (tpad_ouinstance, ((tpad_trip_id)::text), ((COALESCE(tpad_dispatch_doc_no, tpad_doc_no))::text));