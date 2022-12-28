CREATE TABLE raw.raw_wms_spprocess_log (
    raw_id bigint NOT NULL,
    wms_sp_guid character varying(512) NOT NULL COLLATE public.nocase,
    wms_spctxt_user character varying(120) NOT NULL COLLATE public.nocase,
    wms_process character varying(1020) COLLATE public.nocase,
    wms_bn_startdate timestamp without time zone,
    wms_bn_enddate timestamp without time zone,
    wms_grpln_no character varying(72) COLLATE public.nocase,
    wms_grexec_no character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_spprocess_log ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_spprocess_log_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_spprocess_log
    ADD CONSTRAINT raw_wms_spprocess_log_pkey PRIMARY KEY (raw_id);