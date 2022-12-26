CREATE TABLE stg.stg_wms_veh_thucapmap_dtl (
    wms_veh_ou integer NOT NULL,
    wms_veh_id character varying(120) NOT NULL COLLATE public.nocase,
    wms_veh_line_no integer NOT NULL,
    wms_veh_thu character varying(160) COLLATE public.nocase,
    wms_veh_qty numeric,
    wms_veh_qty_uom character varying(40) COLLATE public.nocase,
    wms_veh_pallet_space numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);