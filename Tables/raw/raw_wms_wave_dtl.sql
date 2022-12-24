CREATE TABLE raw.raw_wms_wave_dtl (
    raw_id bigint NOT NULL,
    wms_wave_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_wave_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_wave_lineno integer NOT NULL,
    wms_wave_ou integer NOT NULL,
    wms_wave_so_no character varying(72) COLLATE public.nocase,
    wms_wave_so_sr_no integer,
    wms_wave_so_sch_no integer,
    wms_wave_item_code character varying(128) COLLATE public.nocase,
    wms_wave_qty numeric,
    wms_wave_line_status character varying(32) COLLATE public.nocase,
    wms_wave_outbound_no character varying(72) COLLATE public.nocase,
    wms_wave_customer_code character varying(72) COLLATE public.nocase,
    wms_wave_customer_item_code character varying(128) COLLATE public.nocase,
    wms_wave_tripplan_id character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);