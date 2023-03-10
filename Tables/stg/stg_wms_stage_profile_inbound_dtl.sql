CREATE TABLE stg.stg_wms_stage_profile_inbound_dtl (
    wms_stg_prof_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stg_prof_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stg_prof_ou integer NOT NULL,
    wms_stg_prof_lineno integer NOT NULL,
    wms_stg_prof_stages character varying(40) COLLATE public.nocase,
    wms_stg_prof_sequence numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_stage_profile_inbound_dtl
    ADD CONSTRAINT wms_stage_profile_inbound_dtl_pk PRIMARY KEY (wms_stg_prof_code, wms_stg_prof_loc_code, wms_stg_prof_ou, wms_stg_prof_lineno);