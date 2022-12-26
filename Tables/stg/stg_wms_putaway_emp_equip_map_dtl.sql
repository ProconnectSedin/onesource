CREATE TABLE stg.stg_wms_putaway_emp_equip_map_dtl (
    wms_putaway_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_putaway_ou integer NOT NULL,
    wms_putaway_lineno integer NOT NULL,
    wms_putaway_shift_code character varying(32) COLLATE public.nocase,
    wms_putaway_emp_code character varying(80) COLLATE public.nocase,
    wms_putaway_euip_code character varying(120) COLLATE public.nocase,
    wms_putaway_area character varying(40) COLLATE public.nocase,
    wms_putaway_zone character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);