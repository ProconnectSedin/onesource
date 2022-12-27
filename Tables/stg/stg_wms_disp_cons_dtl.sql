CREATE TABLE stg.stg_wms_disp_cons_dtl (
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

ALTER TABLE ONLY stg.stg_wms_disp_cons_dtl
    ADD CONSTRAINT wms_disp_cons_dtl_pk PRIMARY KEY (wms_disp_location, wms_disp_ou, wms_disp_lineno);