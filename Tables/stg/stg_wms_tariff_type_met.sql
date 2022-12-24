CREATE TABLE stg.stg_wms_tariff_type_met (
    wms_tf_grp_code character varying(32) NOT NULL COLLATE public.nocase,
    wms_tf_type_code character varying(32) NOT NULL COLLATE public.nocase,
    wms_tf_type_desc character varying(1020) COLLATE public.nocase,
    wms_tf_formula character varying(16000) COLLATE public.nocase,
    wms_tf_created_by character varying(120) COLLATE public.nocase,
    wms_tf_created_date timestamp without time zone,
    wms_tf_langid integer,
    wms_tf_acc_flag character varying(32) COLLATE public.nocase,
    wms_tariff_code character varying(160) COLLATE public.nocase,
    wms_description character varying(16000) COLLATE public.nocase,
    formula character varying(16000) COLLATE public.nocase,
    wms_tf_tariff_code_version character varying(160) COLLATE public.nocase,
    wms_tf_br_remit_flag character varying(32) COLLATE public.nocase,
    wms_tf_revenue_split character varying(160) COLLATE public.nocase,
    wms_tf_basicsforop character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);