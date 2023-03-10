CREATE TABLE raw.raw_wms_stage_mas_hdr (
    raw_id bigint NOT NULL,
    wms_stg_mas_ou integer NOT NULL,
    wms_stg_mas_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_stg_mas_desc character varying(1020) COLLATE public.nocase,
    wms_stg_mas_status character varying(160) COLLATE public.nocase,
    wms_stg_mas_loc character varying(40) NOT NULL COLLATE public.nocase,
    wms_stg_mas_type character varying(1020) COLLATE public.nocase,
    wms_stg_mas_def_bin character varying(72) COLLATE public.nocase,
    wms_stg_mas_rsn_code character varying(160) COLLATE public.nocase,
    wms_stg_mas_frm_stage character varying(1020) COLLATE public.nocase,
    wms_stg_mas_frm_doc_typ character varying(160) COLLATE public.nocase,
    wms_stg_mas_frm_doc_status character varying(160) COLLATE public.nocase,
    wms_stg_mas_frm_doc_prefix character varying(80) COLLATE public.nocase,
    wms_stg_mas_frm_doc_conf_req integer,
    wms_stg_mas_to_stage character varying(1020) COLLATE public.nocase,
    wms_stg_mas_to_doc_typ character varying(160) COLLATE public.nocase,
    wms_stg_mas_to_doc_status character varying(160) COLLATE public.nocase,
    wms_stg_mas_to_doc_prefix character varying(80) COLLATE public.nocase,
    wms_stg_mas_to_doc_conf_req integer,
    wms_stg_mas_timestamp integer,
    wms_stg_mas_created_by character varying(120) COLLATE public.nocase,
    wms_stg_mas_created_dt timestamp without time zone,
    wms_stg_mas_modified_by character varying(120) COLLATE public.nocase,
    wms_stg_mas_modified_dt timestamp without time zone,
    wms_stg_mas_user_def1 character varying(1020) COLLATE public.nocase,
    wms_stg_mas_user_def2 character varying(1020) COLLATE public.nocase,
    wms_stg_mas_user_def3 character varying(1020) COLLATE public.nocase,
    wms_stg_mas_height numeric,
    wms_stg_mas_handl_eqp_capa numeric,
    wms_stg_mas_unit character varying(280) COLLATE public.nocase,
    wms_stg_mas_dock_status character varying(1020) COLLATE public.nocase,
    wms_stg_mas_dock_prevstat character varying(32) COLLATE public.nocase,
    wms_stg_mas_frm_stage_typ character varying(32) COLLATE public.nocase,
    wms_stg_mas_to_stage_typ character varying(32) COLLATE public.nocase,
    wms_stg_mas_pack_bin character varying(72) COLLATE public.nocase,
    wms_stg_mas_hgt_uom character varying(280) COLLATE public.nocase,
    wms_stg_uom character varying(40) COLLATE public.nocase,
    wms_stg_length numeric,
    wms_stg_breadth numeric,
    wms_stg_height numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_stage_mas_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_stage_mas_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_stage_mas_hdr
    ADD CONSTRAINT raw_wms_stage_mas_hdr_pkey PRIMARY KEY (raw_id);