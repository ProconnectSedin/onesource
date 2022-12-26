CREATE TABLE stg.stg_tms_ttpmd_tariff_type_process_meta_data (
    ttpmd_tariff_type_code character varying(160) NOT NULL COLLATE public.nocase,
    ttpmd_tariff_desc character varying(1020) NOT NULL COLLATE public.nocase,
    ttpmd_calc_based_on character varying(1020) COLLATE public.nocase,
    ttpmd_base_or_accessorial character varying(160) COLLATE public.nocase,
    ttpmd_appli_sell_buy character varying(1020) COLLATE public.nocase,
    ttpmd_project character varying(1020) COLLATE public.nocase,
    tt_via character varying(160) COLLATE public.nocase,
    ttpmd_trip_flag character varying(32) COLLATE public.nocase,
    ttpmd_level_of_process character varying(160) COLLATE public.nocase,
    ttpmd_job_weight_based character varying(48) COLLATE public.nocase,
    ttpmd_tariff_agent_dtl_based character varying(48) COLLATE public.nocase,
    ttpmd_job_dtl_taken_from character varying(48) COLLATE public.nocase,
    ttpmd_job_sell_ref_type character varying(32) COLLATE public.nocase,
    ttpmd_job_buy_ref_type character varying(32) COLLATE public.nocase,
    ttpmd_job_trig_type character varying(32) COLLATE public.nocase,
    ttpmd_job_based_tariff_yn character varying(48) COLLATE public.nocase,
    ttpmd_railcar_tab_flag character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);