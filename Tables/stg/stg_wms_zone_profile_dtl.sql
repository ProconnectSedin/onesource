CREATE TABLE stg.stg_wms_zone_profile_dtl (
    wms_zone_prof_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_zone_prof_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_zone_prof_ou integer NOT NULL,
    wms_zone_prof_lineno integer NOT NULL,
    wms_zone_prof_zone_code character varying(40) COLLATE public.nocase,
    wms_zone_prof_stor_seq integer NOT NULL,
    wms_zone_prof_stor_unit character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_zone_profile_dtl
    ADD CONSTRAINT wms_zone_profile_dtl_pk PRIMARY KEY (wms_zone_prof_code, wms_zone_prof_loc_code, wms_zone_prof_ou, wms_zone_prof_lineno, wms_zone_prof_stor_seq);