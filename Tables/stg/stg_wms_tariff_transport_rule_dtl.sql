CREATE TABLE stg.stg_wms_tariff_transport_rule_dtl (
    wms_tf_tp_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_tf_tp_ou integer NOT NULL,
    wms_tf_tp_lineno integer NOT NULL,
    wms_tf_tp_condition character varying(32) COLLATE public.nocase,
    wms_tf_tp_table character varying(1020) COLLATE public.nocase,
    wms_tf_tp_field character varying(1020) COLLATE public.nocase,
    wms_tf_tp_operator character varying(32) COLLATE public.nocase,
    wms_tf_tp_unit character varying(1020) COLLATE public.nocase,
    wms_tf_tp_uom character varying(40) COLLATE public.nocase,
    rules_satisfied_yn character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);