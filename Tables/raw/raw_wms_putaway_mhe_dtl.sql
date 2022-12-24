CREATE TABLE raw.raw_wms_putaway_mhe_dtl (
    raw_id bigint NOT NULL,
    wms_putaway_mhe_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_putaway_mhe_ou integer NOT NULL,
    wms_putaway_mhe_lineno integer NOT NULL,
    wms_putaway_mhe_code character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);