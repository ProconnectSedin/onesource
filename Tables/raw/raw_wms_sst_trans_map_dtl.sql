CREATE TABLE raw.raw_wms_sst_trans_map_dtl (
    raw_id bigint NOT NULL,
    wms_stkstatus_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_stkstatus_lineno integer NOT NULL,
    wms_stkstatus_ou integer NOT NULL,
    wms_stkstatus_activity_code character varying(32) COLLATE public.nocase,
    wms_stkstatus_map character varying(32) COLLATE public.nocase,
    wms_stkstatus_created_by character varying(120) COLLATE public.nocase,
    wms_stkstatus_created_date timestamp without time zone,
    wms_stkstatus_modified_by character varying(120) COLLATE public.nocase,
    wms_stkstatus_modified_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_sst_trans_map_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_sst_trans_map_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_sst_trans_map_dtl
    ADD CONSTRAINT raw_wms_sst_trans_map_dtl_pkey PRIMARY KEY (raw_id);