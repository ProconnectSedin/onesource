CREATE TABLE stg.stg_wms_gr_emp_equip_map_dtl (
    wms_gr_loc_code character varying(1020) NOT NULL COLLATE public.nocase,
    wms_gr_ou integer NOT NULL,
    wms_gr_lineno integer NOT NULL,
    wms_gr_shift_code character varying(1020) COLLATE public.nocase,
    wms_gr_emp_code character varying(80) COLLATE public.nocase,
    wms_gr_euip_code character varying(120) COLLATE public.nocase,
    wms_gr_area character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_gr_emp_equip_map_dtl
    ADD CONSTRAINT wms_gr_emp_equip_map_dtl_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_ou, wms_gr_lineno);