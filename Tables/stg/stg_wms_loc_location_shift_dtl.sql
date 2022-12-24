CREATE TABLE stg.stg_wms_loc_location_shift_dtl (
    wms_loc_ou character varying(40) NOT NULL COLLATE public.nocase,
    wms_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loc_shft_lineno integer NOT NULL,
    wms_loc_shft_shift character varying(160) COLLATE public.nocase,
    wms_loc_shft_fr_time timestamp without time zone,
    wms_loc_shft_to_time timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);