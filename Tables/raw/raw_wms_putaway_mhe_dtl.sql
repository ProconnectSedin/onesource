CREATE TABLE raw.raw_wms_putaway_mhe_dtl (
    raw_id bigint NOT NULL,
    wms_putaway_mhe_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_putaway_mhe_ou integer NOT NULL,
    wms_putaway_mhe_lineno integer NOT NULL,
    wms_putaway_mhe_code character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_putaway_mhe_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_putaway_mhe_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_putaway_mhe_dtl
    ADD CONSTRAINT raw_wms_putaway_mhe_dtl_pkey PRIMARY KEY (raw_id);