CREATE TABLE stg.stg_wms_leg_hdr (
    wms_leg_leg_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_leg_ou integer NOT NULL,
    wms_leg_desc character varying(1020) COLLATE public.nocase,
    wms_leg_status character varying(32) COLLATE public.nocase,
    wms_leg_rsn_code character varying(160) COLLATE public.nocase,
    wms_leg_trans_mode character varying(160) COLLATE public.nocase,
    wms_leg_from_geo character varying(160) COLLATE public.nocase,
    wms_leg_to_geo character varying(160) COLLATE public.nocase,
    wms_leg_dist numeric,
    wms_leg_dist_uom character varying(40) COLLATE public.nocase,
    wms_leg_toll_exists integer,
    wms_leg_total_esti_cost numeric,
    wms_leg_cost_cur character(20) COLLATE public.nocase,
    wms_leg_transit_time numeric,
    wms_leg_trans_time_uom character varying(40) COLLATE public.nocase,
    wms_leg_brd_exists integer,
    wms_leg_remarks character varying(1020) COLLATE public.nocase,
    wms_leg_created_by character varying(120) COLLATE public.nocase,
    wms_leg_created_date timestamp without time zone,
    wms_leg_modified_by character varying(120) COLLATE public.nocase,
    wms_leg_modified_date timestamp without time zone,
    wms_leg_timestamp integer,
    wms_leg_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_leg_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_leg_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_leg_from_geo_type character varying(160) COLLATE public.nocase,
    wms_leg_to_geo_type character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_leg_hdr
    ADD CONSTRAINT wms_leg_mst_hdr_pk PRIMARY KEY (wms_leg_leg_id, wms_leg_ou);