CREATE TABLE raw.raw_wms_putaway_error_log (
    raw_id bigint NOT NULL,
    wms_pway_guid character varying(512) NOT NULL COLLATE public.nocase,
    wms_pway_location character varying(40) COLLATE public.nocase,
    wms_pway_gr_no character varying(72) COLLATE public.nocase,
    wms_pway_gr_ln_no integer,
    wms_pway_gr_item character varying(128) COLLATE public.nocase,
    wms_pway_error_msg character varying COLLATE public.nocase,
    wms_pway_run_date timestamp without time zone,
    wms_pway_user character varying(120) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);