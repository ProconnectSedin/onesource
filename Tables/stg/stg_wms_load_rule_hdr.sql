CREATE TABLE stg.stg_wms_load_rule_hdr (
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

ALTER TABLE ONLY stg.stg_wms_load_rule_hdr
    ADD CONSTRAINT wms_load_rule_hdr_pk PRIMARY KEY (wms_load_rule_ou, wms_load_rule_location);