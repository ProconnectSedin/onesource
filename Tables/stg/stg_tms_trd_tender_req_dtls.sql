CREATE TABLE stg.stg_tms_trd_tender_req_dtls (
    trd_ouinstance integer NOT NULL,
    trd_tender_req_no character varying(72) NOT NULL COLLATE public.nocase,
    trd_tender_req_line_no character varying(512) COLLATE public.nocase,
    trd_ref_doc_type character varying(160) COLLATE public.nocase,
    trd_ref_doc_no character varying(160) COLLATE public.nocase,
    trd_from_geo character varying(160) COLLATE public.nocase,
    trd_from_geo_type character varying(160) COLLATE public.nocase,
    trd_to_geo character varying(160) COLLATE public.nocase,
    trd_to_geo_type character varying(160) COLLATE public.nocase,
    trd_req_for_vehicle character(4) COLLATE public.nocase,
    trd_req_for_equipment character(4) COLLATE public.nocase,
    trd_req_for_driver character(4) COLLATE public.nocase,
    trd_req_for_handler character(4) COLLATE public.nocase,
    trd_req_for_services character(4) COLLATE public.nocase,
    trd_req_for_schedule character(4) COLLATE public.nocase,
    trd_req_created_by character varying(120) COLLATE public.nocase,
    trd_req_created_date timestamp without time zone,
    trd_req_last_modified_by character varying(120) COLLATE public.nocase,
    trd_req_last_modified_date timestamp without time zone,
    trd_timestamp integer,
    trd_trip_plan_id character varying(72) COLLATE public.nocase,
    wms_geo_city_desc character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);