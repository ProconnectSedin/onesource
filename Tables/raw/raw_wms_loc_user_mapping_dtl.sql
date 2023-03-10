CREATE TABLE raw.raw_wms_loc_user_mapping_dtl (
    raw_id bigint NOT NULL,
    wms_loc_ou integer NOT NULL,
    wms_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loc_lineno integer NOT NULL,
    wms_loc_user_name character varying(120) COLLATE public.nocase,
    wms_loc_user_admin integer,
    wms_loc_user_planner integer,
    wms_loc_user_executor integer,
    wms_loc_user_controller integer,
    wms_loc_user_default integer,
    wms_loc_status character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_loc_user_mapping_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_loc_user_mapping_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_loc_user_mapping_dtl
    ADD CONSTRAINT raw_wms_loc_user_mapping_dtl_pkey PRIMARY KEY (raw_id);