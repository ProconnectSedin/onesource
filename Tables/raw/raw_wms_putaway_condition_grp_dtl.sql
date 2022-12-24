CREATE TABLE raw.raw_wms_putaway_condition_grp_dtl (
    raw_id bigint NOT NULL,
    wms_pway_ou integer NOT NULL,
    wms_pway_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pway_line_no integer NOT NULL,
    wms_pway_condition_group character varying(1020) COLLATE public.nocase,
    wms_pway_condition_id character varying(1020) COLLATE public.nocase,
    wms_pway_condition_id_ln_no integer,
    wms_pway_operator character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);