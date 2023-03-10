CREATE TABLE raw.raw_wms_ex_itm_su_conversion_dtl (
    raw_id bigint NOT NULL,
    wms_ex_itm_ou integer NOT NULL,
    wms_ex_itm_code character varying(128) NOT NULL COLLATE public.nocase,
    wms_ex_itm_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_ex_itm_line_no integer NOT NULL,
    wms_ex_itm_storage_unit character varying(40) COLLATE public.nocase,
    wms_ex_itm_operator character varying(32) COLLATE public.nocase,
    wms_ex_itm_quantity numeric,
    wms_ex_itm_master_uom character varying(60) COLLATE public.nocase,
    wms_ex_itm_consignee_code character varying(72) COLLATE public.nocase,
    wms_ex_itm_vendor_code character varying(64) COLLATE public.nocase,
    wms_ex_itm_sideload_count numeric,
    wms_ex_itm_stack_ability numeric,
    wms_ex_itm_stack_count numeric,
    wms_ex_itm_stack_height numeric,
    wms_ex_itm_stack_weight numeric,
    wms_ex_itm_su_volume numeric,
    wms_ex_itm_volume_uom character varying(40) COLLATE public.nocase,
    wms_ex_itm_factory_pack character varying(80) COLLATE public.nocase,
    wms_ex_itm_default integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_ex_itm_su_conversion_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_ex_itm_su_conversion_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_ex_itm_su_conversion_dtl
    ADD CONSTRAINT raw_wms_ex_itm_su_conversion_dtl_pkey PRIMARY KEY (raw_id);