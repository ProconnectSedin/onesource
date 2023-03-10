CREATE TABLE raw.raw_wms_gr_rule_hdr (
    raw_id bigint NOT NULL,
    wms_gr_loc_code character varying(1020) NOT NULL COLLATE public.nocase,
    wms_gr_ou integer NOT NULL,
    wms_gr_build_pallet integer,
    wms_gr_active_consumables integer,
    wms_gr_created_by character varying(120) COLLATE public.nocase,
    wms_gr_created_date timestamp without time zone,
    wms_gr_modified_by character varying(120) COLLATE public.nocase,
    wms_gr_modified_date timestamp without time zone,
    wms_gr_timestamp integer,
    wms_gr_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_gr_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_gr_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_gr_auto_print integer,
    wms_gr_report character varying(1020) COLLATE public.nocase,
    wms_gr_su_default character varying(32) COLLATE public.nocase,
    wms_gr_su_split character varying(32) COLLATE public.nocase,
    wms_gr_lbl_prt character varying(32) COLLATE public.nocase,
    wms_gr_cross_sdoc character varying(32) COLLATE public.nocase,
    wms_gr_pack_done character varying(32) COLLATE public.nocase,
    wms_gr_part_qty_req character varying(32) COLLATE public.nocase,
    wms_gr_su_map character varying(32) COLLATE public.nocase,
    wms_gr_thu_across integer,
    wms_gr_suggested_thu integer,
    wms_gr_mandate_instage character varying(80) COLLATE public.nocase,
    wms_gr_def_stagingid character varying(72) COLLATE public.nocase,
    wms_gr_mandate_uid character varying(80) COLLATE public.nocase,
    wms_gr_def_su character varying(40) COLLATE public.nocase,
    wms_gr_def_thuid character varying(160) COLLATE public.nocase,
    wms_gr_vas_applicable character varying(80) COLLATE public.nocase,
    wms_ex_item_validation character varying(32) COLLATE public.nocase,
    wms_gr_fresh_check_notification character varying(32) COLLATE public.nocase,
    wms_gr_release_pway character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_gr_rule_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_gr_rule_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_gr_rule_hdr
    ADD CONSTRAINT raw_wms_gr_rule_hdr_pkey PRIMARY KEY (raw_id);