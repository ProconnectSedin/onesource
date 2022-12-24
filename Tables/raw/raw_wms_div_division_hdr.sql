CREATE TABLE raw.raw_wms_div_division_hdr (
    raw_id bigint NOT NULL,
    wms_div_ou integer NOT NULL,
    wms_div_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_div_desc character varying(1020) COLLATE public.nocase,
    wms_div_status character varying(32) COLLATE public.nocase,
    wms_div_type character varying(160) COLLATE public.nocase,
    wms_div_reason_code character varying(40) COLLATE public.nocase,
    wms_div_user_def1 character varying(1020) COLLATE public.nocase,
    wms_div_user_def2 character varying(1020) COLLATE public.nocase,
    wms_div_user_def3 character varying(1020) COLLATE public.nocase,
    wms_div_timestamp integer,
    wms_div_created_by character varying(120) COLLATE public.nocase,
    wms_div_created_dt timestamp without time zone,
    wms_div_modified_by character varying(120) COLLATE public.nocase,
    wms_div_modified_dt timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);