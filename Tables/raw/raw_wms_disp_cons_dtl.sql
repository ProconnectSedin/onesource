CREATE TABLE raw.raw_wms_disp_cons_dtl (
    raw_id bigint NOT NULL,
    wms_disp_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_disp_ou integer NOT NULL,
    wms_disp_lineno integer NOT NULL,
    wms_disp_profile_code character varying(72) COLLATE public.nocase,
    wms_disp_customer character varying(72) COLLATE public.nocase,
    wms_disp_lsp character varying(64) COLLATE public.nocase,
    wms_disp_ship_mode character varying(1020) COLLATE public.nocase,
    wms_disp_route character varying(1020) COLLATE public.nocase,
    wms_disp_ship_point character varying(1020) COLLATE public.nocase,
    wms_disp_thuid character varying(1020) COLLATE public.nocase,
    wms_disp_delivery_date character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_disp_cons_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_disp_cons_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_disp_cons_dtl
    ADD CONSTRAINT raw_wms_disp_cons_dtl_pkey PRIMARY KEY (raw_id);