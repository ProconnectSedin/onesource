CREATE TABLE raw.raw_wms_putaway_zone_dtl (
    raw_id bigint NOT NULL,
    wms_putaway_zn_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_putaway_zn_ou integer NOT NULL,
    wms_putaway_zn_lineno integer NOT NULL,
    wms_putaway_zn_code character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);