CREATE TABLE raw.raw_wms_customer_location_division_dtl (
    raw_id bigint NOT NULL,
    wms_customer_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_customer_ou integer NOT NULL,
    wms_customer_lineno integer NOT NULL,
    wms_customer_type character varying(32) COLLATE public.nocase,
    wms_customer_code character varying(40) COLLATE public.nocase,
    wms_customer_itm_val_contract integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);