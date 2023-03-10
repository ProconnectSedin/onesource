CREATE TABLE raw.raw_wms_thu_hdr (
    raw_id bigint NOT NULL,
    wms_thu_id character varying(160) NOT NULL COLLATE public.nocase,
    wms_thu_ou integer NOT NULL,
    wms_thu_description character varying(1020) COLLATE public.nocase,
    wms_thu_bulk integer,
    wms_thu_class character varying(160) COLLATE public.nocase,
    wms_thu_status character varying(32) COLLATE public.nocase,
    wms_thu_reason_code character varying(160) COLLATE public.nocase,
    wms_thu_tare numeric,
    wms_thu_max_allowable numeric,
    wms_thu_weight_uom character varying(40) COLLATE public.nocase,
    wms_thu_material character varying(160) COLLATE public.nocase,
    wms_thu_uom character varying(40) COLLATE public.nocase,
    wms_thu_int_length numeric,
    wms_thu_int_width numeric,
    wms_thu_int_height numeric,
    wms_thu_int_uom character varying(40) COLLATE public.nocase,
    wms_thu_ext_length numeric,
    wms_thu_ext_width numeric,
    wms_thu_ext_height numeric,
    wms_thu_ext_uom character varying(40) COLLATE public.nocase,
    wms_thu_timestamp integer,
    wms_thu_created_by character varying(120) COLLATE public.nocase,
    wms_thu_created_date timestamp without time zone,
    wms_thu_modified_by character varying(120) COLLATE public.nocase,
    wms_thu_modified_date timestamp without time zone,
    wms_thu_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_thu_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_thu_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_thu_size character varying(160) COLLATE public.nocase,
    wms_thu_eligible_cubing integer,
    wms_thu_area numeric,
    wms_thu_area_uom character varying(40) COLLATE public.nocase,
    wms_thu_weight_const integer,
    wms_thu_volume_const integer,
    wms_thu_unit_pallet_const integer,
    wms_thu_max_unit_permissable integer,
    wms_thu_stage_mapping integer,
    wms_thu_ser_cont integer,
    wms_thu_is_ethu integer,
    wms_thu_volume_uom character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_thu_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_thu_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_thu_hdr
    ADD CONSTRAINT raw_wms_thu_hdr_pkey PRIMARY KEY (raw_id);