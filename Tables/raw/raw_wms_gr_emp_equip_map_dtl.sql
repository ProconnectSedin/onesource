CREATE TABLE raw.raw_wms_gr_emp_equip_map_dtl (
    raw_id bigint NOT NULL,
    wms_gr_loc_code character varying(1020) NOT NULL COLLATE public.nocase,
    wms_gr_ou integer NOT NULL,
    wms_gr_lineno integer NOT NULL,
    wms_gr_shift_code character varying(1020) COLLATE public.nocase,
    wms_gr_emp_code character varying(80) COLLATE public.nocase,
    wms_gr_euip_code character varying(120) COLLATE public.nocase,
    wms_gr_area character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);