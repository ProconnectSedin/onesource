CREATE TABLE stg.stg_wms_quick_code_master_met (
    wms_code_type character varying(1020) NOT NULL COLLATE public.nocase,
    wms_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_code_desc character varying(1020) COLLATE public.nocase,
    wms_default character varying(32) COLLATE public.nocase,
    wms_seq_no integer,
    wms_category character varying(32) COLLATE public.nocase,
    wms_user_flag character varying(32) COLLATE public.nocase,
    wms_langid integer,
    wms_created_date timestamp without time zone,
    wms_created_by character varying(120) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);