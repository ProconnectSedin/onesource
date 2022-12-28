CREATE TABLE stg.stg_wms_putaway_zone_dtl (
    wms_putaway_zn_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_putaway_zn_ou integer NOT NULL,
    wms_putaway_zn_lineno integer NOT NULL,
    wms_putaway_zn_code character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_putaway_zone_dtl
    ADD CONSTRAINT wms_putaway_zone_dtl_pk PRIMARY KEY (wms_putaway_zn_loc_code, wms_putaway_zn_ou, wms_putaway_zn_lineno);