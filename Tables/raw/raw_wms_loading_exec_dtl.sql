CREATE TABLE raw.raw_wms_loading_exec_dtl (
    raw_id bigint NOT NULL,
    wms_loading_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loading_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_loading_exec_ou integer NOT NULL,
    wms_loading_lineno integer NOT NULL,
    wms_loading_thu_id character varying(160) COLLATE public.nocase,
    wms_loading_ship_point character varying(72) COLLATE public.nocase,
    wms_loading_disp_doc_type character varying(32) COLLATE public.nocase,
    wms_loading_disp_doc_no character varying(72) COLLATE public.nocase,
    wms_loading_transfer_doc character varying(1020) COLLATE public.nocase,
    wms_loading_thu_desc character varying(1020) COLLATE public.nocase,
    wms_loading_thu_class character varying(160) COLLATE public.nocase,
    wms_loading_thu_sr_no character varying(112) COLLATE public.nocase,
    wms_loading_thu_acc character varying(280) COLLATE public.nocase,
    wms_loading_disp_doc_date timestamp without time zone,
    wms_loading_pal_qty numeric,
    wms_loading_tran_typ character varying(32) COLLATE public.nocase,
    wms_loading_ven_thuid character varying(160) COLLATE public.nocase,
    wms_loading_start_date_time timestamp without time zone,
    wms_loading_end_date_time timestamp without time zone,
    wms_loading_so_no character varying(72) COLLATE public.nocase,
    wms_unload_flag character varying(60) COLLATE public.nocase,
    wms_loading_thu_sr_no2 character varying(112) COLLATE public.nocase,
    wms_loading_reason_code character varying(1020) COLLATE public.nocase,
    wms_loading_userdef1 character varying(1020) COLLATE public.nocase,
    wms_loading_userdef2 character varying(1020) COLLATE public.nocase,
    wms_loading_userdef3 character varying(1020) COLLATE public.nocase,
    wms_loading_userdef4 timestamp without time zone,
    wms_loading_userdef5 timestamp without time zone,
    wms_loading_stage character varying(100) COLLATE public.nocase,
    wms_loading_curr_exec character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_loading_exec_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_loading_exec_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_loading_exec_dtl
    ADD CONSTRAINT raw_wms_loading_exec_dtl_pkey PRIMARY KEY (raw_id);