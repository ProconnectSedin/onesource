CREATE TABLE raw.raw_wms_pick_plan_hdr (
    raw_id bigint NOT NULL,
    wms_pick_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pick_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_pick_pln_ou integer NOT NULL,
    wms_pick_pln_date timestamp without time zone,
    wms_pick_pln_status character varying(32) COLLATE public.nocase,
    wms_pick_employee character varying(160) COLLATE public.nocase,
    wms_pick_mhe character varying(120) COLLATE public.nocase,
    wms_pick_staging_id character varying(72) COLLATE public.nocase,
    wms_pick_source_stage character varying(1020) COLLATE public.nocase,
    wms_pick_source_docno character varying(72) COLLATE public.nocase,
    wms_pick_created_by character varying(120) COLLATE public.nocase,
    wms_pick_created_date timestamp without time zone,
    wms_pick_modified_by character varying(120) COLLATE public.nocase,
    wms_pick_modified_date timestamp without time zone,
    wms_pick_timestamp integer,
    wms_pick_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_pick_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_pick_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_pick_output_pln character varying(32) COLLATE public.nocase,
    wms_pick_steps character varying(80) COLLATE public.nocase,
    wms_pick_pln_urgent integer,
    wms_pick_second_pln_no character varying(72) COLLATE public.nocase,
    wms_pick_completed_flag character varying(32) COLLATE public.nocase,
    wms_pick_pln_type character varying(32) DEFAULT 'NR'::character varying COLLATE public.nocase,
    wms_pick_zone_pickby character varying(32) COLLATE public.nocase,
    wms_pick_conso_pln_no character varying(72) COLLATE public.nocase,
    wms_consolidated_pick_flg character varying(32) COLLATE public.nocase,
    wms_pick_loose_flg character varying(32) COLLATE public.nocase,
    wms_pick_consol_auto_cmplt character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_pick_plan_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_pick_plan_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_pick_plan_hdr
    ADD CONSTRAINT raw_wms_pick_plan_hdr_pkey PRIMARY KEY (raw_id);