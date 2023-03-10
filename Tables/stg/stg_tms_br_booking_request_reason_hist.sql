CREATE TABLE stg.stg_tms_br_booking_request_reason_hist (
    row_id bigint,
    br_ouinstance integer,
    br_request_id character varying(72) COLLATE public.nocase,
    amend_no integer,
    br_status character varying(160) COLLATE public.nocase,
    reason_code character varying(160) COLLATE public.nocase,
    reason_desc character varying(1020) COLLATE public.nocase,
    created_date character varying(100) COLLATE public.nocase,
    created_by character varying(120) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);