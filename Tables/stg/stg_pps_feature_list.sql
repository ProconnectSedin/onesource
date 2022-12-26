CREATE TABLE stg.stg_pps_feature_list (
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