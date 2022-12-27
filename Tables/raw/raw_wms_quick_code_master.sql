CREATE TABLE raw.raw_wms_quick_code_master (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_wms_quick_code_master ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_quick_code_master_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_quick_code_master
    ADD CONSTRAINT raw_wms_quick_code_master_pkey PRIMARY KEY (raw_id);