CREATE TABLE raw.raw_wms_ex_itm_zone_check_dtl (
    raw_id bigint NOT NULL,
    wms_ex_zn_ou integer NOT NULL,
    wms_ex_zn_itm_code character varying(128) NOT NULL COLLATE public.nocase,
    wms_ex_zn_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_ex_zn_line_no integer NOT NULL,
    wms_ex_zn_zone character varying(40) COLLATE public.nocase,
    wms_ex_zn_per_qty numeric,
    wms_ex_zn_stag_chk integer,
    wms_ex_zn_dest character varying(1020) COLLATE public.nocase,
    wms_ex_zn_dest_type character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_ex_itm_zone_check_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_ex_itm_zone_check_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_ex_itm_zone_check_dtl
    ADD CONSTRAINT raw_wms_ex_itm_zone_check_dtl_pkey PRIMARY KEY (raw_id);