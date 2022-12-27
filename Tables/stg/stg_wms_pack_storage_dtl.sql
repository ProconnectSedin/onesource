CREATE TABLE stg.stg_wms_pack_storage_dtl (
    wms_pack_location character varying(1020) NOT NULL COLLATE public.nocase,
    wms_pack_ou integer NOT NULL,
    wms_pack_lineno integer NOT NULL,
    wms_pack_storage_zone character varying(40) COLLATE public.nocase,
    wms_pack_pack_zone character varying(40) COLLATE public.nocase,
    wms_pack_service_type character varying(1020) COLLATE public.nocase,
    wms_pack_order_type character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_pack_storage_dtl
    ADD CONSTRAINT wms_pack_storage_dtl_pk PRIMARY KEY (wms_pack_location, wms_pack_ou, wms_pack_lineno);

CREATE INDEX stg_wms_pack_storage_dtl_idx ON stg.stg_wms_pack_storage_dtl USING btree (wms_pack_location, wms_pack_ou, wms_pack_lineno);