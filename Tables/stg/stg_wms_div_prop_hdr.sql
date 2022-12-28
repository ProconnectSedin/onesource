CREATE TABLE stg.stg_wms_div_prop_hdr (
    wms_div_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_div_ou integer NOT NULL,
    wms_div_length numeric,
    wms_div_breath numeric,
    wms_div_height numeric,
    wms_div_uom character varying(40) COLLATE public.nocase,
    wms_div_area_uom character varying(40) COLLATE public.nocase,
    wms_div_tot_area numeric,
    wms_div_tot_stag_area numeric,
    wms_div_storg_area numeric,
    wms_div_tot_docks numeric,
    wms_div_other_area numeric,
    wms_div_office_area numeric,
    wms_div_outbound_area numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_div_prop_hdr
    ADD CONSTRAINT wms_div_prop_hdr_pk PRIMARY KEY (wms_div_code, wms_div_ou);