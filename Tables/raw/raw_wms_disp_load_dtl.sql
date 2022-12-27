CREATE TABLE raw.raw_wms_disp_load_dtl (
    raw_id bigint NOT NULL,
    wms_disp_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_disp_ou integer NOT NULL,
    wms_disp_lineno integer NOT NULL,
    wms_disp_customer character varying(72) COLLATE public.nocase,
    wms_disp_profile character varying(72) COLLATE public.nocase,
    wms_disp_route character varying(72) COLLATE public.nocase,
    wms_disp_geo character varying(160) COLLATE public.nocase,
    wms_disp_consignee character varying(72) COLLATE public.nocase,
    wms_disp_ship_point character varying(1020) COLLATE public.nocase,
    wms_disp_ship_mode character varying(1020) COLLATE public.nocase,
    wms_disp_urgent character varying(1020) COLLATE public.nocase,
    wms_disp_domestic character varying(160) COLLATE public.nocase,
    wms_disp_lsp character varying(80) COLLATE public.nocase,
    wms_disp_lsp_email character varying(240) COLLATE public.nocase,
    wms_disp_customer_email character varying(240) COLLATE public.nocase,
    wms_disp_integ_tms character varying(1020) COLLATE public.nocase,
    wms_disp_status character varying(1020) COLLATE public.nocase,
    wms_disp_tms_location character varying(40) COLLATE public.nocase,
    wms_disp_geo_type character varying(40) COLLATE public.nocase,
    wms_disp_dispatch_bay character varying(72) COLLATE public.nocase,
    wms_disp_bkreq_status character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_disp_load_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_disp_load_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_disp_load_dtl
    ADD CONSTRAINT raw_wms_disp_load_dtl_pkey PRIMARY KEY (raw_id);