CREATE TABLE stg.stg_wms_putaway_mhe_dtl (
    wms_putaway_mhe_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_putaway_mhe_ou integer NOT NULL,
    wms_putaway_mhe_lineno integer NOT NULL,
    wms_putaway_mhe_code character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_putaway_mhe_dtl
    ADD CONSTRAINT wms_putaway_mhe_dtl_pk PRIMARY KEY (wms_putaway_mhe_loc_code, wms_putaway_mhe_ou, wms_putaway_mhe_lineno);