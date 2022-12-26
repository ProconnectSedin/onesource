CREATE TABLE stg.stg_wms_veh_maint_dtl (
    wms_veh_maint_ou integer NOT NULL,
    wms_veh_maint_id character varying(120) NOT NULL COLLATE public.nocase,
    wms_veh_maint_line integer NOT NULL,
    wms_veh_maint_loc character varying(120) COLLATE public.nocase,
    wms_veh_maint_frm timestamp without time zone,
    wms_veh_maint_to timestamp without time zone,
    wms_veh_maint_desc character varying(1020) COLLATE public.nocase,
    wms_veh_maint_catgry character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);