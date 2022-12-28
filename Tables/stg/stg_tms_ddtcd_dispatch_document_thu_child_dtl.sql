CREATE TABLE stg.stg_tms_ddtcd_dispatch_document_thu_child_dtl (
    ddtcd_ouinstance integer NOT NULL,
    ddtcd_dispatch_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    ddtcd_thu_line_no character varying(512) NOT NULL COLLATE public.nocase,
    ddtcd_thu_child_line_no character varying(512) NOT NULL COLLATE public.nocase,
    ddtcd_thu_child_id character varying(160) COLLATE public.nocase,
    ddtcd_thu_child_serial_no character varying(160) COLLATE public.nocase,
    ddtcd_thu_child_qty numeric,
    ddtcd_created_by character varying(120) COLLATE public.nocase,
    ddtcd_created_date timestamp without time zone,
    ddtcd_last_modified_by character varying(120) COLLATE public.nocase,
    ddtcd_lst_modified_date timestamp without time zone,
    ddtcd_timestamp integer,
    ddtcd_main_thu_child_serial_no character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_ddtcd_dispatch_document_thu_child_dtl
    ADD CONSTRAINT pk_tms_ddtcd_dispatch_document_thu_child_dtl PRIMARY KEY (ddtcd_ouinstance, ddtcd_dispatch_doc_no, ddtcd_thu_line_no, ddtcd_thu_child_line_no);