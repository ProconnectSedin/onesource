CREATE TABLE raw.raw_wms_load_rule_hdr (
    raw_id bigint NOT NULL,
    wms_load_rule_ou integer NOT NULL,
    wms_load_rule_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_load_rule_activate_unload integer,
    wms_load_rule_created_by character varying(120) COLLATE public.nocase,
    wms_gr_created_date timestamp without time zone,
    wms_gr_modified_by character varying(120) COLLATE public.nocase,
    wms_gr_modified_date timestamp without time zone,
    wms_gr_timestamp integer,
    wms_load_allow_loading_from character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);