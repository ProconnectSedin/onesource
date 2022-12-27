CREATE TABLE raw.raw_lbc_offline_wms_stock_uid_tracking_gi_dtl_stag (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_lbc_offline_wms_stock_uid_tracking_gi_dtl_stag ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_lbc_offline_wms_stock_uid_tracking_gi_dtl_stag_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_lbc_offline_wms_stock_uid_tracking_gi_dtl_stag
    ADD CONSTRAINT raw_lbc_offline_wms_stock_uid_tracking_gi_dtl_stag_pkey PRIMARY KEY (raw_id);