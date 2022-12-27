CREATE TABLE stg.stg_wms_quick_code_master (
    wms_code_ou integer NOT NULL,
    wms_code_type character varying(1020) NOT NULL COLLATE public.nocase,
    wms_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_code_desc character varying(160) COLLATE public.nocase,
    wms_default character varying(32) COLLATE public.nocase,
    wms_seq_no integer,
    wms_status character varying(32) COLLATE public.nocase,
    wms_category character varying(32) COLLATE public.nocase,
    wms_user_flag character varying(32) COLLATE public.nocase,
    wms_timestamp integer,
    wms_langid integer,
    wms_created_date timestamp without time zone,
    wms_created_by character varying(120) COLLATE public.nocase,
    wms_modified_date timestamp without time zone,
    wms_modified_by character varying(120) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_quick_code_master
    ADD CONSTRAINT wms_quick_code_master_pk PRIMARY KEY (wms_code_ou, wms_code_type, wms_code);