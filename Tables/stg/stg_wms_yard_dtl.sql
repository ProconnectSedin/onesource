CREATE TABLE stg.stg_wms_yard_dtl (
    wms_yard_id character varying(40) NOT NULL COLLATE public.nocase,
    wms_yard_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_yard_ou integer NOT NULL,
    wms_yard_lineno integer NOT NULL,
    wms_yard_parking_slot character varying(72) COLLATE public.nocase,
    wms_yard_parking_status character varying(32) COLLATE public.nocase,
    wms_yard_parking_prevstatus character varying(32) COLLATE public.nocase,
    wms_yard_parking_type character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);