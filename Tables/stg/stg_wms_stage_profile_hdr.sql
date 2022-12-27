CREATE TABLE stg.stg_wms_stage_profile_hdr (
    wms_stg_prof_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stg_prof_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stg_prof_ou integer NOT NULL,
    wms_stg_prof_desc character varying(600) COLLATE public.nocase,
    wms_stg_prof_status character varying(32) COLLATE public.nocase,
    wms_stg_prof_reason_code character varying(160) COLLATE public.nocase,
    wms_stg_prof_timestamp integer,
    wms_stg_prof_created_by character varying(120) COLLATE public.nocase,
    wms_stg_prof_created_date timestamp without time zone,
    wms_stg_prof_modified_by character varying(120) COLLATE public.nocase,
    wms_stg_prof_modified_date timestamp without time zone,
    wms_stg_prof_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_stg_prof_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_stg_prof_userdefined3 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_stage_profile_hdr
    ADD CONSTRAINT wms_stage_profile_hdr_pk PRIMARY KEY (wms_stg_prof_code, wms_stg_prof_loc_code, wms_stg_prof_ou);