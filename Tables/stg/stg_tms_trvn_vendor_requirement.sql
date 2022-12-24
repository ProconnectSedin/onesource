CREATE TABLE stg.stg_tms_trvn_vendor_requirement (
    trvn_ouinstance integer NOT NULL,
    trvn_tender_req_no character varying(72) NOT NULL COLLATE public.nocase,
    trvn_line_no character varying(512) COLLATE public.nocase,
    trvn_vendor_id character varying(64) COLLATE public.nocase,
    trvn_created_by character varying(120) COLLATE public.nocase,
    trvn_created_date timestamp without time zone,
    trvn_last_modified_by character varying(120) COLLATE public.nocase,
    trvn_last_modified_date timestamp without time zone,
    trvn_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);