CREATE TABLE raw.raw_wms_disp_rules_hdr (
    raw_id bigint NOT NULL,
    wms_disp_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_disp_ou integer NOT NULL,
    wms_disp_schedule character varying(32) COLLATE public.nocase,
    wms_disp_manual_trg_time timestamp without time zone,
    wms_disp_packing_time timestamp without time zone,
    wms_disp_cutoff_time timestamp without time zone,
    wms_disp_load numeric,
    wms_disp_load_uom character varying(40) COLLATE public.nocase,
    wms_disp_load_allocation character varying(1020) COLLATE public.nocase,
    wms_disp_lsp character varying(64) COLLATE public.nocase,
    wms_disp_timestamp integer,
    wms_disp_created_by character varying(120) COLLATE public.nocase,
    wms_disp_created_date timestamp without time zone,
    wms_disp_modified_by character varying(120) COLLATE public.nocase,
    wms_disp_modified_date timestamp without time zone,
    wms_disp_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_disp_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_disp_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_disp_tms_location character varying(40) COLLATE public.nocase,
    wms_disp_integ_tms character varying(32) COLLATE public.nocase,
    wms_disp_bkreq_status character varying(1020) COLLATE public.nocase,
    pcs_autoload character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_disp_rules_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_disp_rules_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_disp_rules_hdr
    ADD CONSTRAINT raw_wms_disp_rules_hdr_pkey PRIMARY KEY (raw_id);