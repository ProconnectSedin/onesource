CREATE TABLE stg.stg_wms_pick_rules_hdr (
    wms_pick_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pick_ou integer NOT NULL,
    wms_pick_schedule character varying(1020) COLLATE public.nocase,
    wms_pick_outputlist character varying(1020) COLLATE public.nocase,
    wms_pick_eqp_assign character varying(32) COLLATE public.nocase,
    wms_pick_emp_assign character varying(32) COLLATE public.nocase,
    wms_pick_timestamp integer,
    wms_pick_created_by character varying(120) COLLATE public.nocase,
    wms_pick_created_date timestamp without time zone,
    wms_pick_modified_by character varying(120) COLLATE public.nocase,
    wms_pick_modified_date timestamp without time zone,
    wms_pick_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_pick_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_pick_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_pick_countback_func integer,
    wms_pick_auto_deconsol character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);