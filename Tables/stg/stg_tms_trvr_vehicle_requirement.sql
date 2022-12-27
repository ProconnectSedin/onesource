CREATE TABLE stg.stg_tms_trvr_vehicle_requirement (
    trvr_ouinstance integer NOT NULL,
    trvr_tender_req_no character varying(72) NOT NULL COLLATE public.nocase,
    trvr_line_no character varying(512) COLLATE public.nocase,
    trvr_vehicle_type character varying(160) COLLATE public.nocase,
    trvr_no_of_vehicles integer,
    trvr_required_date_time timestamp without time zone,
    trvr_pref_vehicle_model character varying(160) COLLATE public.nocase,
    trvr_created_by character varying(120) COLLATE public.nocase,
    trvr_created_date timestamp without time zone,
    trvr_last_modified_by character varying(120) COLLATE public.nocase,
    trvr_last_modified_date timestamp without time zone,
    trvr_timestamp integer,
    trvr_for_period numeric,
    trvr_period_uom character varying(160) COLLATE public.nocase,
    trvr_ref_doc_no character varying(160) COLLATE public.nocase,
    trvr_ref_doc_type character varying(160) COLLATE public.nocase,
    trvr_tender_to character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);