CREATE TABLE stg.stg_wms_div_location_list_dtl (
    wms_div_ou integer NOT NULL,
    wms_div_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_div_lineno integer NOT NULL,
    wms_div_loc_code character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_div_location_list_dtl
    ADD CONSTRAINT wms_div_location_list_dtl_pk PRIMARY KEY (wms_div_ou, wms_div_code, wms_div_lineno);