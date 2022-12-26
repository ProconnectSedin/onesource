CREATE TABLE raw.raw_wms_putaway_bin_capacity_dtl (
    raw_id bigint NOT NULL,
    wms_pway_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pway_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_pway_pln_ou integer NOT NULL,
    wms_pway_lineno integer NOT NULL,
    wms_pway_item_ln_no integer,
    wms_pway_item character varying(128) COLLATE public.nocase,
    wms_pway_bin character varying(40) COLLATE public.nocase,
    wms_pway_occu_capacity numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);