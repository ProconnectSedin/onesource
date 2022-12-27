CREATE TABLE raw.raw_wms_stage_profile_inbound_dtl (
    raw_id bigint NOT NULL,
    wms_stg_prof_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stg_prof_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stg_prof_ou integer NOT NULL,
    wms_stg_prof_lineno integer NOT NULL,
    wms_stg_prof_stages character varying(40) COLLATE public.nocase,
    wms_stg_prof_sequence numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_stage_profile_inbound_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_stage_profile_inbound_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_stage_profile_inbound_dtl
    ADD CONSTRAINT raw_wms_stage_profile_inbound_dtl_pkey PRIMARY KEY (raw_id);