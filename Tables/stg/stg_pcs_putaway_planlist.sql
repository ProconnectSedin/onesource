CREATE TABLE stg.stg_pcs_putaway_planlist (
    wms_putaway_emp_code character varying(80) COLLATE public.nocase,
    wms_emp_user character varying(120) COLLATE public.nocase,
    wms_plan_no character varying(72) COLLATE public.nocase,
    wms_putaway_euip_code character varying(120) COLLATE public.nocase,
    wms_putaway_loc_code character varying(40) COLLATE public.nocase,
    wms_created_date timestamp without time zone,
    wms_seq_no integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);