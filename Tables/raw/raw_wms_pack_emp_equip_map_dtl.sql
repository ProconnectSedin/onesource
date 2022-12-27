CREATE TABLE raw.raw_wms_pack_emp_equip_map_dtl (
    raw_id bigint NOT NULL,
    wms_pack_loc_code character varying(1020) NOT NULL COLLATE public.nocase,
    wms_pack_ou integer NOT NULL,
    wms_pack_lineno integer NOT NULL,
    wms_pack_shift_code character varying(1020) COLLATE public.nocase,
    wms_pack_emp_code character varying(80) COLLATE public.nocase,
    wms_pack_mhe_code character varying(120) COLLATE public.nocase,
    wms_pack_area character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_pack_emp_equip_map_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_pack_emp_equip_map_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_pack_emp_equip_map_dtl
    ADD CONSTRAINT raw_wms_pack_emp_equip_map_dtl_pkey PRIMARY KEY (raw_id);