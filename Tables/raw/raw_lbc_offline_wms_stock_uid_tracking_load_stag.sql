CREATE TABLE raw.raw_lbc_offline_wms_stock_uid_tracking_load_stag (
    raw_id bigint NOT NULL,
    running_no bigint NOT NULL,
    ouinstance integer,
    ctxt_user character varying(120) COLLATE public.nocase,
    ctxt_language integer,
    ctxt_service character varying(160) COLLATE public.nocase,
    ctxt_role character varying(160) COLLATE public.nocase,
    location character varying(160) COLLATE public.nocase,
    guid character varying(512) COLLATE public.nocase,
    execution_no character varying(160) COLLATE public.nocase,
    gi_no character varying(160) COLLATE public.nocase,
    trantype character varying(160) COLLATE public.nocase,
    status_flag character varying(160) DEFAULT 'Pending'::character varying COLLATE public.nocase,
    entry_date timestamp without time zone DEFAULT now(),
    read_time timestamp without time zone,
    process_date timestamp without time zone,
    re_trigger_count integer DEFAULT 0,
    session_id integer,
    error_msg character varying COLLATE public.nocase,
    qname character varying(80) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_lbc_offline_wms_stock_uid_tracking_load_stag ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_lbc_offline_wms_stock_uid_tracking_load_stag_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_lbc_offline_wms_stock_uid_tracking_load_stag ALTER COLUMN running_no ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_lbc_offline_wms_stock_uid_tracking_load_stag_running_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_lbc_offline_wms_stock_uid_tracking_load_stag
    ADD CONSTRAINT raw_lbc_offline_wms_stock_uid_tracking_load_stag_pkey PRIMARY KEY (raw_id);