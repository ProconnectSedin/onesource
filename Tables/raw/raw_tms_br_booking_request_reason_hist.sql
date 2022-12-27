CREATE TABLE raw.raw_tms_br_booking_request_reason_hist (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_tms_br_booking_request_reason_hist ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_br_booking_request_reason_hist_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_br_booking_request_reason_hist
    ADD CONSTRAINT raw_tms_br_booking_request_reason_hist_pkey PRIMARY KEY (raw_id);