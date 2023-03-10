CREATE TABLE raw.raw_wms_transient_thu_log (
    raw_id bigint NOT NULL,
    wms_trans_thu_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_trans_thu_ou integer NOT NULL,
    wms_trans_thu_lineno integer NOT NULL,
    wms_trans_thu_id character varying(160) COLLATE public.nocase,
    wms_trans_thu_serial_no character varying(112) COLLATE public.nocase,
    wms_trans_thu_type character varying(160) COLLATE public.nocase,
    wms_trans_thu_dest_id character varying(1020) COLLATE public.nocase,
    wms_trans_thu_activity character varying(1020) COLLATE public.nocase,
    wms_trans_thu_main_stage character varying(72) COLLATE public.nocase,
    wms_trans_thu_in_stage character varying(1020) COLLATE public.nocase,
    wms_trans_thu_pallet_status character varying(1020) COLLATE public.nocase,
    wms_trans_thu_createdby character varying(120) COLLATE public.nocase,
    wms_trans_thu_created_date timestamp without time zone,
    wms_trans_thu_modifiedby character varying(120) COLLATE public.nocase,
    wms_trans_thu_modified_date timestamp without time zone,
    wms_trans_thu_in_stage_seq_no integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_transient_thu_log ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_transient_thu_log_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_transient_thu_log
    ADD CONSTRAINT raw_wms_transient_thu_log_pkey PRIMARY KEY (raw_id);