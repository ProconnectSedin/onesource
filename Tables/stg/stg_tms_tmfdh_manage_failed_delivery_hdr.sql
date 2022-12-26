CREATE TABLE stg.stg_tms_tmfdh_manage_failed_delivery_hdr (
    tmfdh_ouinstance integer,
    tmfdh_br_id character varying(160) COLLATE public.nocase,
    tmfdh_dispatch_doc character varying(160) COLLATE public.nocase,
    tmfdh_status character varying(160) COLLATE public.nocase,
    tmfdh_reason_code character varying(160) COLLATE public.nocase,
    tmfdh_guid character varying(512) COLLATE public.nocase,
    tmfdh_created_by character varying(160) COLLATE public.nocase,
    tmfdh_created_date timestamp without time zone,
    tmfdh_modified_by character varying(160) COLLATE public.nocase,
    tmfdh_modified_date timestamp without time zone,
    tmfdh_timestamp integer,
    tmfdh_thu_line_no character varying(512) COLLATE public.nocase,
    tmfdh_thu_id character varying(160) COLLATE public.nocase,
    tmfdh_action_qty numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);