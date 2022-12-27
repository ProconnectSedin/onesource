CREATE TABLE raw.raw_wms_bin_type_storage_dtl (
    raw_id bigint NOT NULL,
    wms_bin_typ_ou integer NOT NULL,
    wms_bin_typ_code character varying(80) NOT NULL COLLATE public.nocase,
    wms_bin_typ_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_bin_typ_lineno integer NOT NULL,
    wms_bin_typ_storage_unit character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_bin_type_storage_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_bin_type_storage_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_bin_type_storage_dtl
    ADD CONSTRAINT raw_wms_bin_type_storage_dtl_pkey PRIMARY KEY (raw_id);