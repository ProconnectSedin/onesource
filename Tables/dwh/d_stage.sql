CREATE TABLE dwh.d_stage (
    stg_mas_key bigint NOT NULL,
    stg_mas_ou integer,
    stg_mas_id character varying(40) COLLATE public.nocase,
    stg_mas_desc character varying(510) COLLATE public.nocase,
    stg_mas_status character varying(80) COLLATE public.nocase,
    stg_mas_loc character varying(20) COLLATE public.nocase,
    stg_mas_type character varying(510) COLLATE public.nocase,
    stg_mas_def_bin character varying(40) COLLATE public.nocase,
    stg_mas_rsn_code character varying(80) COLLATE public.nocase,
    stg_mas_frm_stage character varying(510) COLLATE public.nocase,
    stg_mas_frm_doc_typ character varying(80) COLLATE public.nocase,
    stg_mas_frm_doc_status character varying(80) COLLATE public.nocase,
    stg_mas_frm_doc_conf_req integer,
    stg_mas_to_stage character varying(510) COLLATE public.nocase,
    stg_mas_to_doc_typ character varying(80) COLLATE public.nocase,
    stg_mas_to_doc_status character varying(80) COLLATE public.nocase,
    stg_mas_to_doc_conf_req integer,
    stg_mas_timestamp integer,
    stg_mas_created_by character varying(60) COLLATE public.nocase,
    stg_mas_created_dt timestamp without time zone,
    stg_mas_modified_by character varying(60) COLLATE public.nocase,
    stg_mas_modified_dt timestamp without time zone,
    stg_mas_dock_status character varying(510) COLLATE public.nocase,
    stg_mas_dock_prevstat character varying(20) COLLATE public.nocase,
    stg_mas_frm_stage_typ character varying(20) COLLATE public.nocase,
    stg_mas_to_stage_typ character varying(20) COLLATE public.nocase,
    stg_mas_pack_bin character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_stage ALTER COLUMN stg_mas_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_stage_stg_mas_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_stage
    ADD CONSTRAINT d_stage_pkey PRIMARY KEY (stg_mas_key);

ALTER TABLE ONLY dwh.d_stage
    ADD CONSTRAINT d_stage_ukey UNIQUE (stg_mas_ou, stg_mas_id, stg_mas_loc);