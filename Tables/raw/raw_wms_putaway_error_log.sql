CREATE TABLE raw.raw_wms_putaway_error_log (
    raw_id bigint NOT NULL,
    wms_pway_guid character varying(512) NOT NULL COLLATE public.nocase,
    wms_pway_location character varying(40) COLLATE public.nocase,
    wms_pway_gr_no character varying(72) COLLATE public.nocase,
    wms_pway_gr_ln_no integer,
    wms_pway_gr_item character varying(128) COLLATE public.nocase,
    wms_pway_error_msg character varying COLLATE public.nocase,
    wms_pway_run_date timestamp without time zone,
    wms_pway_user character varying(120) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_putaway_error_log ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_putaway_error_log_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_putaway_error_log
    ADD CONSTRAINT raw_wms_putaway_error_log_pkey PRIMARY KEY (raw_id);