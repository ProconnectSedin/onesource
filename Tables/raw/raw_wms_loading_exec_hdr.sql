CREATE TABLE raw.raw_wms_loading_exec_hdr (
    raw_id bigint NOT NULL,
    wms_loading_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loading_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_loading_exec_ou integer NOT NULL,
    wms_loading_exec_date timestamp without time zone,
    wms_loading_exec_status character varying(32) COLLATE public.nocase,
    wms_loading_ld_sheet_no character varying(72) COLLATE public.nocase,
    wms_loading_dock character varying(72) COLLATE public.nocase,
    wms_loading_mhe character varying(120) COLLATE public.nocase,
    wms_loading_employee character varying(80) COLLATE public.nocase,
    wms_loading_packing_bay character varying(72) COLLATE public.nocase,
    wms_loading_veh_type character varying(160) COLLATE public.nocase,
    wms_loading_veh_no character varying(120) COLLATE public.nocase,
    wms_laoding_equip_type character varying(160) COLLATE public.nocase,
    wms_laoding_equip_no character varying(120) COLLATE public.nocase,
    wms_loading_container_no character varying(72) COLLATE public.nocase,
    wms_loading_person character varying(1020) COLLATE public.nocase,
    wms_loading_lsp character varying(64) COLLATE public.nocase,
    wms_loading_created_by character varying(120) COLLATE public.nocase,
    wms_loading_created_date timestamp without time zone,
    wms_loading_modified_by character varying(120) COLLATE public.nocase,
    wms_loading_modified_date timestamp without time zone,
    wms_loading_timestamp integer,
    wms_loading_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_loading_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_loading_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_loading_manifest_no character varying(72) COLLATE public.nocase,
    wms_loading_exec_startdate timestamp without time zone,
    wms_loading_exec_enddate timestamp without time zone,
    wms_loading_exe_urgent integer,
    wms_loading_exec_seal_no character varying(1020) COLLATE public.nocase,
    wms_loading_booking_req character varying(72) COLLATE public.nocase,
    wms_loading_manf_flag character varying(32) COLLATE public.nocase,
    wms_loading_gen_from character varying(32) COLLATE public.nocase,
    wms_loading_rsn_code character varying(160) COLLATE public.nocase,
    wms_loading_trip_planid character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_loading_exec_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_loading_exec_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_loading_exec_hdr
    ADD CONSTRAINT raw_wms_loading_exec_hdr_pkey PRIMARY KEY (raw_id);