CREATE TABLE stg.stg_wms_sst_trans_map_dtl (
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

ALTER TABLE ONLY stg.stg_wms_sst_trans_map_dtl
    ADD CONSTRAINT wms_sst_trans_map_dtl_pk PRIMARY KEY (wms_stkstatus_code, wms_stkstatus_lineno, wms_stkstatus_ou);