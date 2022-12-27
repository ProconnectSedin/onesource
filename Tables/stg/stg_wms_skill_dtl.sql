CREATE TABLE stg.stg_wms_skill_dtl (
    wms_skl_ou integer NOT NULL,
    wms_skl_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_skl_loc_code character varying(40) COLLATE public.nocase,
    wms_skl_type character varying(160) NOT NULL COLLATE public.nocase,
    wms_skl_desc character varying(1020) COLLATE public.nocase,
    wms_skl_rate numeric,
    wms_skl_currency character(20) COLLATE public.nocase,
    wms_skl_per integer,
    wms_skl_unit character varying(40) COLLATE public.nocase,
    wms_skl_status character varying(32) COLLATE public.nocase,
    wms_skl_timestamp integer,
    wms_skl_created_by character varying(120) COLLATE public.nocase,
    wms_skl_created_dt timestamp without time zone,
    wms_skl_modified_by character varying(120) COLLATE public.nocase,
    wms_skl_modified_dt timestamp without time zone,
    wms_skl_user_def1 character varying(1020) COLLATE public.nocase,
    wms_skl_user_def2 character varying(1020) COLLATE public.nocase,
    wms_skl_user_def3 character varying(1020) COLLATE public.nocase,
    wms_skl_lineno integer NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_skill_dtl
    ADD CONSTRAINT wms_skill_dtl_pk PRIMARY KEY (wms_skl_ou, wms_skl_code, wms_skl_type);