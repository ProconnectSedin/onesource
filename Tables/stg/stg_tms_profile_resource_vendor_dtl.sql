CREATE TABLE stg.stg_tms_profile_resource_vendor_dtl (
    tprvd_ouinstance integer,
    tprvd_profile_id character varying(160) COLLATE public.nocase,
    tprvd_resource_type character varying(160) COLLATE public.nocase,
    tprvd_resource_category character varying(160) COLLATE public.nocase,
    tprvd_resource_id character varying(160) COLLATE public.nocase,
    tprvd_resource_capacity numeric,
    tprvd_guid character varying(512) COLLATE public.nocase,
    tprvd_created_by character varying(120) COLLATE public.nocase,
    tprvd_created_date character varying(100) COLLATE public.nocase,
    tprvd_modified_by character varying(120) COLLATE public.nocase,
    tprvd_modified_date character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);