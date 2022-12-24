CREATE TABLE raw.raw_wms_tariff_type_master (
    raw_id bigint NOT NULL,
    wms_tar_lineno integer NOT NULL,
    wms_tar_ou integer NOT NULL,
    wms_tar_applicability integer,
    wms_tar_scr_code character varying(32) NOT NULL COLLATE public.nocase,
    wms_tar_type_code character varying(32) NOT NULL COLLATE public.nocase,
    wms_tar_tf_type character varying(1020) COLLATE public.nocase,
    wms_tar_display_tf_type character varying(1020) COLLATE public.nocase,
    wms_tar_created_by character varying(120) COLLATE public.nocase,
    wms_tar_created_date timestamp without time zone,
    wms_tar_modified_by character varying(120) COLLATE public.nocase,
    wms_tar_modified_date timestamp without time zone,
    wms_tar_timestamp integer,
    wms_tar_revenue_split character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);