CREATE TABLE stg.stg_wms_ex_itm_fix_bin_dtl (
    wms_ex_itm_ou integer NOT NULL,
    wms_ex_itm_code character varying(128) NOT NULL COLLATE public.nocase,
    wms_ex_itm_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_ex_itm_line_no integer NOT NULL,
    wms_ex_itm_zone character varying(40) NOT NULL COLLATE public.nocase,
    wms_ex_itm_bin character varying(40) NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);