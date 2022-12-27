CREATE TABLE raw.raw_pps_feature_list (
    raw_id bigint NOT NULL,
    feature_id character varying(160) NOT NULL COLLATE public.nocase,
    feature_desc character varying(8000) COLLATE public.nocase,
    flag_yes_no character(20) NOT NULL COLLATE public.nocase,
    component_name character varying(160) COLLATE public.nocase,
    activity_name character varying(160) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    created_date timestamp without time zone,
    max_record_count integer DEFAULT 0,
    new_remarks character varying(1020) COLLATE public.nocase,
    bpc character varying(160) DEFAULT 'GEN'::character varying NOT NULL COLLATE public.nocase,
    generic character(20) DEFAULT 'N'::bpchar NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pps_feature_list ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pps_feature_list_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pps_feature_list
    ADD CONSTRAINT raw_pps_feature_list_pkey PRIMARY KEY (raw_id);