CREATE TABLE raw.raw_wms_pack_emp_equip_map_dtl (
    raw_id bigint NOT NULL,
    wms_pack_loc_code character varying(1020) NOT NULL COLLATE public.nocase,
    wms_pack_ou integer NOT NULL,
    wms_pack_lineno integer NOT NULL,
    wms_pack_shift_code character varying(1020) COLLATE public.nocase,
    wms_pack_emp_code character varying(80) COLLATE public.nocase,
    wms_pack_mhe_code character varying(120) COLLATE public.nocase,
    wms_pack_area character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);