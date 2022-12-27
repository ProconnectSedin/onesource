CREATE TABLE raw.raw_wms_ex_itm_fix_bin_dtl (
    raw_id bigint NOT NULL,
    wms_ex_itm_ou integer NOT NULL,
    wms_ex_itm_code character varying(128) NOT NULL COLLATE public.nocase,
    wms_ex_itm_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_ex_itm_line_no integer NOT NULL,
    wms_ex_itm_zone character varying(40) NOT NULL COLLATE public.nocase,
    wms_ex_itm_bin character varying(40) NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_ex_itm_fix_bin_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_ex_itm_fix_bin_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_ex_itm_fix_bin_dtl
    ADD CONSTRAINT raw_wms_ex_itm_fix_bin_dtl_pkey PRIMARY KEY (raw_id);