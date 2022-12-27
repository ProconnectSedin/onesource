CREATE TABLE raw.raw_wms_zone_hdr (
    raw_id bigint NOT NULL,
    wms_zone_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_zone_ou integer NOT NULL,
    wms_zone_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_zone_description character varying(600) COLLATE public.nocase,
    wms_zone_status character varying(32) COLLATE public.nocase,
    wms_zone_reason character varying(160) COLLATE public.nocase,
    wms_zone_type character varying(160) COLLATE public.nocase,
    wms_zone_overflow_zone character varying(40) COLLATE public.nocase,
    wms_zone_singlestep_pick integer,
    wms_zone_doublestep_pick integer,
    wms_zone_minimum numeric,
    wms_zone_maximum numeric,
    wms_zone_uom character varying(40) COLLATE public.nocase,
    wms_zone_pick_strategy character varying(160) COLLATE public.nocase,
    wms_zone_pick_req_confirm integer,
    wms_zone_block_picking integer,
    wms_zone_pick_label integer,
    wms_zone_pick_per_picklist numeric,
    wms_zone_pick_by character varying(160) COLLATE public.nocase,
    wms_zone_pick_sequence character varying(160) COLLATE public.nocase,
    wms_zone_put_strategy character varying(160) COLLATE public.nocase,
    wms_zone_put_req_confirm integer,
    wms_zone_add_existing_stk integer,
    wms_zone_block_putaway integer,
    wms_zone_capacity_check integer,
    wms_zone_mixed_storage integer,
    wms_zone_mixed_stor_strategy character varying(160) COLLATE public.nocase,
    wms_zone_timestamp integer,
    wms_zone_created_by character varying(120) COLLATE public.nocase,
    wms_zone_created_date timestamp without time zone,
    wms_zone_modified_by character varying(120) COLLATE public.nocase,
    wms_zone_modified_date timestamp without time zone,
    wms_zone_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_zone_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_zone_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_zone_step character varying(80) COLLATE public.nocase,
    wms_zone_pick character varying(32) COLLATE public.nocase,
    wms_zone_matchpallet_qty integer,
    wms_zone_batch_allowed integer,
    wms_zone_uid_allowed integer,
    wms_zone_pick_stage character varying(32) COLLATE public.nocase,
    wms_zone_putaway_stage character varying(32) COLLATE public.nocase,
    wms_zone_cap_chk character varying(1020) COLLATE public.nocase,
    wms_zone_packing character(12) COLLATE public.nocase,
    wms_zone_adv_pick_strategy character varying(32) COLLATE public.nocase,
    wms_zone_adv_pwy_strategy character varying(1020) COLLATE public.nocase,
    pcs_zone_putaway_strategy character varying(1020) COLLATE public.nocase,
    pcs_noofmnth integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_zone_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_zone_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_zone_hdr
    ADD CONSTRAINT raw_wms_zone_hdr_pkey PRIMARY KEY (raw_id);