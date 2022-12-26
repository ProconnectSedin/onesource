CREATE TABLE raw.raw_wms_stage_def_mas (
    raw_id bigint NOT NULL,
    wms_stg_ou integer NOT NULL,
    wms_stg_code character varying(32) NOT NULL COLLATE public.nocase,
    wms_stg_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_stg_desc character varying(1020) NOT NULL COLLATE public.nocase,
    wms_stg_type character varying(1020) COLLATE public.nocase,
    wms_stg_mandatory_flag character varying(32) COLLATE public.nocase,
    wms_stg_seq_no integer NOT NULL,
    wms_langid integer,
    wms_created_date timestamp without time zone,
    wms_created_by character varying(120) COLLATE public.nocase,
    wms_stg_appl character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);