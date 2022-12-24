CREATE TABLE raw.raw_wms_div_location_list_dtl (
    raw_id bigint NOT NULL,
    wms_div_ou integer NOT NULL,
    wms_div_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_div_lineno integer NOT NULL,
    wms_div_loc_code character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);