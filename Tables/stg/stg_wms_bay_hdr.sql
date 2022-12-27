CREATE TABLE stg.stg_wms_bay_hdr (
    wms_bay_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_bay_ou integer NOT NULL,
    wms_bay_type character varying(160) COLLATE public.nocase,
    wms_bay_status character varying(32) COLLATE public.nocase,
    wms_bay_description character varying(1020) COLLATE public.nocase,
    wms_lim_thu_include_flag character varying(32) COLLATE public.nocase,
    wms_lim_mhe_include_flag character varying(32) COLLATE public.nocase,
    wms_dock_height numeric,
    wms_dock_height_unit character varying(40) COLLATE public.nocase,
    wms_dock_eq_hdl_cap numeric,
    wms_dock_eq_hdl_cap_unit character varying(40) COLLATE public.nocase,
    wms_user_def1 character varying(1020) COLLATE public.nocase,
    wms_user_def2 character varying(1020) COLLATE public.nocase,
    wms_user_def3 character varying(1020) COLLATE public.nocase,
    wms_timestamp integer,
    wms_created_by character varying(120) COLLATE public.nocase,
    wms_created_dt timestamp without time zone,
    wms_modified_by character varying(120) COLLATE public.nocase,
    wms_modified_dt timestamp without time zone,
    wms_bay_hubid character varying(40) COLLATE public.nocase,
    wms_bay_reefer character varying(32) COLLATE public.nocase,
    wms_bay_cls_of_store character varying(160) COLLATE public.nocase,
    wms_is_frozen character varying(32) COLLATE public.nocase,
    wms_lnkd_wh character varying(160) COLLATE public.nocase,
    wms_bay_linked_warehouse character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_bay_hdr
    ADD CONSTRAINT wms_bay_hdr_pk PRIMARY KEY (wms_bay_id, wms_bay_ou);