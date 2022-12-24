CREATE TABLE stg.stg_tms_trmd_tariff_rules_meta_data (
    tms_tf_tp_table character varying(1020) COLLATE public.nocase,
    tms_tf_tp_field character varying(1020) COLLATE public.nocase,
    tms_tf_tp_actual_table_name character varying(1020) COLLATE public.nocase,
    tms_tf_tp_actual_field_name character varying(1020) COLLATE public.nocase,
    derived_query character varying COLLATE public.nocase,
    derived_query_sell character varying COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);