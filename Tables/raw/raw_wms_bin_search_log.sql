CREATE TABLE raw.raw_wms_bin_search_log (
    raw_id bigint NOT NULL,
    wms_bnsrch_guid character varying(512) NOT NULL COLLATE public.nocase,
    wms_bnctxt_user character varying(120) NOT NULL COLLATE public.nocase,
    wms_bn_startdate timestamp without time zone,
    wms_bn_location character varying(40) COLLATE public.nocase,
    wms_bn_grno character varying(72) COLLATE public.nocase,
    wms_bin character varying(40) COLLATE public.nocase,
    wms_uid character varying(112) COLLATE public.nocase,
    wms_item character varying(128) COLLATE public.nocase,
    wms_lotno character varying(112) COLLATE public.nocase,
    wms_stock_status character varying(160) COLLATE public.nocase,
    wms_zone character varying(40) COLLATE public.nocase,
    wms_gr_lineno integer,
    iteration_count integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_bin_search_log ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_bin_search_log_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_bin_search_log
    ADD CONSTRAINT raw_wms_bin_search_log_pkey PRIMARY KEY (raw_id);