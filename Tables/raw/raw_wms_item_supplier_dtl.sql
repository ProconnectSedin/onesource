CREATE TABLE raw.raw_wms_item_supplier_dtl (
    raw_id bigint NOT NULL,
    wms_itm_ou integer NOT NULL,
    wms_itm_code character varying(128) NOT NULL COLLATE public.nocase,
    wms_itm_lineno integer NOT NULL,
    wms_itm_supp_code character varying(64) COLLATE public.nocase,
    wms_item_source character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);