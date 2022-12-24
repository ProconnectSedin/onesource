CREATE TABLE stg.stg_tms_dds_dispatch_document_signature (
    dds_ouinstance integer NOT NULL,
    dds_trip_id character varying(160) NOT NULL COLLATE public.nocase,
    dds_seqno integer NOT NULL,
    dds_dispatch_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    dds_name character varying(160) COLLATE public.nocase,
    dds_signature character varying COLLATE public.nocase,
    dds_remarks character varying(1024) COLLATE public.nocase,
    dds_feedback character varying(100) COLLATE public.nocase,
    dds_signature_status character varying(100) COLLATE public.nocase,
    dds_id_type character varying(160) COLLATE public.nocase,
    dds_id_no character varying(160) COLLATE public.nocase,
    dds_designation character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);