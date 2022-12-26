CREATE TABLE stg.stg_tms_qbruc_quick_booking_request_uom_conversion (
    qbruc_ouinstance integer,
    qbruc_class character varying(160) COLLATE public.nocase,
    qbruc_from_uom character varying(40) COLLATE public.nocase,
    qbruc_to_uom character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);