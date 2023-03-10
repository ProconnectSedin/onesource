CREATE TABLE stg.stg_tms_trip_log_vas_details_hdr (
    tlvd_ouinstance integer NOT NULL,
    tlvd_dispatch_no character varying(72) COLLATE public.nocase,
    tlvd_trip_no character varying(72) NOT NULL COLLATE public.nocase,
    tlvd_vas_code character varying(600) COLLATE public.nocase,
    tlvd_start_datetime character varying(100) COLLATE public.nocase,
    tlvd_end_datetime character varying(100) COLLATE public.nocase,
    tlvd_number_of_thu numeric,
    tlvd_total_weight numeric,
    tlvd_weight_uom character varying(120) COLLATE public.nocase,
    tlvd_total_volume numeric,
    tlvd_volume_uom character varying(120) COLLATE public.nocase,
    tlvd_guid character varying(512) NOT NULL COLLATE public.nocase,
    tlvd_created_by character varying(120) NOT NULL COLLATE public.nocase,
    tlvd_created_date timestamp without time zone NOT NULL,
    tlvd_modified_by character varying(120) COLLATE public.nocase,
    tlvd_modified_date timestamp without time zone,
    tlvd_remarks character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_trip_log_vas_details_hdr
    ADD CONSTRAINT tms_trip_log_vas_details_hdr_pk PRIMARY KEY (tlvd_ouinstance, tlvd_trip_no, tlvd_guid);