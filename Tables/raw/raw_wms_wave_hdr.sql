CREATE TABLE raw.raw_wms_wave_hdr (
    raw_id bigint NOT NULL,
    wms_wave_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_wave_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_wave_ou integer NOT NULL,
    wms_wave_date timestamp without time zone,
    wms_wave_status character varying(32) COLLATE public.nocase,
    wms_wave_pln_start_date timestamp without time zone,
    wms_wave_pln_end_date timestamp without time zone,
    wms_wave_timestamp integer,
    wms_wave_created_by character varying(120) COLLATE public.nocase,
    wms_wave_created_date timestamp without time zone,
    wms_wave_modified_by character varying(120) COLLATE public.nocase,
    wms_wave_modified_date timestamp without time zone,
    wms_wave_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_wave_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_wave_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_wave_alloc_rule character varying(32) COLLATE public.nocase,
    wms_wave_alloc_value numeric,
    wms_wave_alloc_uom character varying(32) COLLATE public.nocase,
    wms_wave_no_of_pickers integer,
    wms_wave_run_no character varying(72) COLLATE public.nocase,
    wms_wave_gen_flag character varying(32) COLLATE public.nocase,
    wms_wave_staging_id character varying(72) COLLATE public.nocase,
    wms_wave_replenish_flag character varying(48) DEFAULT 'N'::character varying NOT NULL COLLATE public.nocase,
    wms_consolidated_flg character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_wave_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_wave_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_wave_hdr
    ADD CONSTRAINT raw_wms_wave_hdr_pkey PRIMARY KEY (raw_id);