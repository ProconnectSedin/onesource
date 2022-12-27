CREATE TABLE stg.stg_wms_ex_itm_zone_check_dtl (
    wms_ex_zn_ou integer NOT NULL,
    wms_ex_zn_itm_code character varying(128) NOT NULL COLLATE public.nocase,
    wms_ex_zn_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_ex_zn_line_no integer NOT NULL,
    wms_ex_zn_zone character varying(40) COLLATE public.nocase,
    wms_ex_zn_per_qty numeric,
    wms_ex_zn_stag_chk integer,
    wms_ex_zn_dest character varying(1020) COLLATE public.nocase,
    wms_ex_zn_dest_type character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_ex_itm_zone_check_dtl
    ADD CONSTRAINT wms_ex_itm_zone_check_dtl_pk PRIMARY KEY (wms_ex_zn_ou, wms_ex_zn_itm_code, wms_ex_zn_loc_code, wms_ex_zn_line_no);