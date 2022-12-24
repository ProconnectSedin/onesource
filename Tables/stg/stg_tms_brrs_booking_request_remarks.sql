CREATE TABLE stg.stg_tms_brrs_booking_request_remarks (
    brrs_ouinstance integer NOT NULL,
    brrs_br_id character varying(72) NOT NULL COLLATE public.nocase,
    brrs_guid character varying(512) NOT NULL COLLATE public.nocase,
    brrs_remarks_action character varying(160) COLLATE public.nocase,
    brrs_remarks character varying(8000) COLLATE public.nocase,
    brrs_created_by character varying(120) COLLATE public.nocase,
    brrs_created_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);