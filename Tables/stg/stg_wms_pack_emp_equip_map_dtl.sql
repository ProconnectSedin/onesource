CREATE TABLE stg.stg_wms_pack_emp_equip_map_dtl (
    wms_pack_loc_code character varying(1020) NOT NULL COLLATE public.nocase,
    wms_pack_ou integer NOT NULL,
    wms_pack_lineno integer NOT NULL,
    wms_pack_shift_code character varying(1020) COLLATE public.nocase,
    wms_pack_emp_code character varying(80) COLLATE public.nocase,
    wms_pack_mhe_code character varying(120) COLLATE public.nocase,
    wms_pack_area character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_pack_emp_equip_map_dtl
    ADD CONSTRAINT wms_pack_emp_equip_map_dtl_pk PRIMARY KEY (wms_pack_loc_code, wms_pack_ou, wms_pack_lineno);