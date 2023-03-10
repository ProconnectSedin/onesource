CREATE TABLE stg.stg_tms_vdd_verify_doc_detail (
    vdd_ouinstance integer NOT NULL,
    vdd_doc_type_hdr character varying(160) COLLATE public.nocase,
    vdd_doc_no_hdr character varying(1020) NOT NULL COLLATE public.nocase,
    vdd_doc_prof_id character varying(160) COLLATE public.nocase,
    vdd_cust_code character varying(160) COLLATE public.nocase,
    vdd_cust_name character varying(1020) COLLATE public.nocase,
    vdd_vend_code character varying(160) COLLATE public.nocase,
    vdd_vend_name character varying(1020) COLLATE public.nocase,
    vdd_doc_type_ml character varying(160) COLLATE public.nocase,
    vdd_doc_name_ml character varying(1020) COLLATE public.nocase,
    vdd_doc_date_ml timestamp without time zone,
    vdd_no_copies_exp integer,
    vdd_no_copies_recv integer,
    vdd_recv_by character varying(1020) COLLATE public.nocase,
    vdd_recv_date timestamp without time zone,
    vdd_validate_by character varying(1020) COLLATE public.nocase,
    vdd_validate_date timestamp without time zone,
    vdd_doc_attachment character varying(600) COLLATE public.nocase,
    vdd_remarks character varying(16000) COLLATE public.nocase,
    vdd_verify_doc_guid character varying(512) NOT NULL COLLATE public.nocase,
    vdd_creation_date character varying(100) COLLATE public.nocase,
    vdd_created_by character varying(120) COLLATE public.nocase,
    vdd_last_modified_date character varying(100) COLLATE public.nocase,
    vdd_last_modified_by character varying(120) COLLATE public.nocase,
    vdd_timestamp integer,
    vdd_doc_ver_status character varying(160) COLLATE public.nocase,
    vdd_src_of_sup_doc character varying(160) COLLATE public.nocase,
    vdd_reason_code character varying(160) COLLATE public.nocase,
    vdd_validation_document character varying(160) COLLATE public.nocase,
    vdd_validation_document_type character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);