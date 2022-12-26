CREATE TABLE stg.stg_wms_stage_transfer_aisle_dtl (
    wms_stage_transfer_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stage_transfer_zone_ou integer NOT NULL,
    wms_stage_transfer_lineno integer NOT NULL,
    wms_stage_transfer_stage_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_stage_transfer_zone_code character varying(40) COLLATE public.nocase,
    wms_stage_transfer_mhe_type character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);