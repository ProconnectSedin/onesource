CREATE TABLE stg.stg_wms_bin_type_storage_dtl (
    wms_bin_typ_ou integer NOT NULL,
    wms_bin_typ_code character varying(80) NOT NULL COLLATE public.nocase,
    wms_bin_typ_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_bin_typ_lineno integer NOT NULL,
    wms_bin_typ_storage_unit character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_bin_type_storage_dtl
    ADD CONSTRAINT wms_bin_type_storage_dtl_pk PRIMARY KEY (wms_bin_typ_ou, wms_bin_typ_code, wms_bin_typ_loc_code, wms_bin_typ_lineno);