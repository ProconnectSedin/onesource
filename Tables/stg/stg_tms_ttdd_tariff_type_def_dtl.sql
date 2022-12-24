CREATE TABLE stg.stg_tms_ttdd_tariff_type_def_dtl (
    tms_ttdd_line_no integer NOT NULL,
    tms_ttdd_tariff_type_code character varying(32) NOT NULL COLLATE public.nocase,
    tms_ttdd_ou integer NOT NULL,
    tms_ttdd_operator character varying(160) COLLATE public.nocase,
    tms_ttdd_f_metacode character varying(160) COLLATE public.nocase,
    tms_ttdd_s_metacode character varying(160) COLLATE public.nocase,
    tms_ttdd_groupby_field character varying(160) COLLATE public.nocase,
    tms_ttdd_created_by character varying(120) COLLATE public.nocase,
    tms_ttdd_created_date timestamp without time zone,
    tms_ttdd_modified_by character varying(120) COLLATE public.nocase,
    tms_ttdd_modified_date timestamp without time zone,
    tms_ttdd_timestamp integer,
    tms_ttdd_line_lvl_query character varying COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);