CREATE TABLE raw.raw_wms_itm_apmg (
    raw_id bigint NOT NULL,
    itemcode character varying(100) COLLATE public.nocase,
    sbugroup character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_itm_apmg ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_itm_apmg_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_itm_apmg
    ADD CONSTRAINT raw_wms_itm_apmg_pkey PRIMARY KEY (raw_id);