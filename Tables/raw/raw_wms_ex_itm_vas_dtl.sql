CREATE TABLE raw.raw_wms_ex_itm_vas_dtl (
    raw_id bigint NOT NULL,
    wms_ex_itm_ou integer NOT NULL,
    wms_ex_itm_code character varying(128) NOT NULL COLLATE public.nocase,
    wms_ex_itm_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_ex_itm_line_no integer NOT NULL,
    wms_ex_itm_vas character varying(72) COLLATE public.nocase,
    wms_ex_itm_vas_default integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);