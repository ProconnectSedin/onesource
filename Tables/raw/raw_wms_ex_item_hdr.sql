CREATE TABLE raw.raw_wms_ex_item_hdr (
    raw_id bigint NOT NULL,
    wms_ex_itm_ou integer NOT NULL,
    wms_ex_itm_code character varying(128) NOT NULL COLLATE public.nocase,
    wms_ex_itm_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_ex_itm_desc character varying(600) COLLATE public.nocase,
    wms_ex_itm_cap_profile character varying(40) COLLATE public.nocase,
    wms_ex_itm_zone_profile character varying(40) COLLATE public.nocase,
    wms_ex_itm_stage_profile character varying(72) COLLATE public.nocase,
    wms_ex_itm_effective_frm timestamp without time zone,
    wms_ex_itm_effective_to timestamp without time zone,
    wms_ex_itm_pick_per_tol_pos numeric,
    wms_ex_itm_pick_per_tol_neg numeric,
    wms_ex_itm_pick_uom_tol_pos numeric,
    wms_ex_itm_pick_uom_tol_neg numeric,
    wms_ex_itm_put_per_tol_pos numeric,
    wms_ex_itm_put_per_tol_neg numeric,
    wms_ex_itm_put_uom_tol_pos numeric,
    wms_ex_itm_put_uom_tol_neg numeric,
    wms_ex_itm_mininum_qty numeric,
    wms_ex_itm_maximum_qty numeric,
    wms_ex_itm_replen_qty numeric,
    wms_ex_itm_master_uom character varying(40) COLLATE public.nocase,
    wms_ex_itm_timestamp integer,
    wms_ex_itm_created_by character varying(120) COLLATE public.nocase,
    wms_ex_itm_created_dt timestamp without time zone,
    wms_ex_itm_modified_by character varying(120) COLLATE public.nocase,
    wms_ex_itm_modified_dt timestamp without time zone,
    wms_ex_itm_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_ex_itm_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_ex_itm_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_ex_itm_packing_bay character varying(72) COLLATE public.nocase,
    wms_ex_itm_low_stk_lvl numeric,
    wms_ex_itm_std_strg_thu_id character varying(160) COLLATE public.nocase,
    wms_ex_itm_stock_per_thu_id numeric,
    wms_ex_itm_uid_prof character varying(1020) COLLATE public.nocase,
    wms_ex_itm_dflt_status character varying(160) COLLATE public.nocase,
    wms_ex_itm_wave_repln_req character varying(160) COLLATE public.nocase,
    wms_ex_itm_mul_rep_low_stk_lvl numeric,
    wms_ex_itm_mul_tar_zone character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_ex_item_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_ex_item_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_ex_item_hdr
    ADD CONSTRAINT raw_wms_ex_item_hdr_pkey PRIMARY KEY (raw_id);