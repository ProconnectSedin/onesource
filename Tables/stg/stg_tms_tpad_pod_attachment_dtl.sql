CREATE TABLE stg.stg_tms_tpad_pod_attachment_dtl (
    tpad_ouinstance integer NOT NULL,
    tpad_trip_id character varying(160) COLLATE public.nocase,
    tpad_seqno integer,
    tpad_line_no character varying(512) NOT NULL COLLATE public.nocase,
    tpad_doc_no character varying(160) COLLATE public.nocase,
    tpad_document_code character varying(160) COLLATE public.nocase,
    tpad_attachment_file_name character varying(1020) COLLATE public.nocase,
    tpad_attachment character varying COLLATE public.nocase,
    tpad_remarks character varying(1020) COLLATE public.nocase,
    tpad_created_by character varying(120) COLLATE public.nocase,
    tpad_created_date timestamp without time zone,
    tpad_last_updated_by character varying(120) COLLATE public.nocase,
    tpad_last_updated_date timestamp without time zone,
    tpad_timestamp integer,
    tpad_addln_doc_no character varying(160) COLLATE public.nocase,
    tpad_doc_type character varying(160) COLLATE public.nocase,
    tpad_hdn_file_name character varying(1020) COLLATE public.nocase,
    tpad_parent_guid character varying(512) COLLATE public.nocase,
    tpad_dispatch_doc_no character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_tpad_pod_attachment_dtl
    ADD CONSTRAINT pk__tms_tpad__d1314a7beb620e7e PRIMARY KEY (tpad_line_no);