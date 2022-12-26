CREATE TABLE stg.stg_lbc_offline_wms_stock_uid_tracking_gi_dtl_stag (
    guid character varying(512) COLLATE public.nocase,
    execution_no character varying(160) COLLATE public.nocase,
    so_no character varying(160) COLLATE public.nocase,
    odo_no character varying(160) COLLATE public.nocase,
    gi_no character varying(160) COLLATE public.nocase,
    trantype character varying(160) COLLATE public.nocase,
    recpt_iss_flag character varying(160) COLLATE public.nocase,
    entry_date timestamp without time zone DEFAULT now(),
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);