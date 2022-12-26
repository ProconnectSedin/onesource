CREATE TABLE raw.raw_pcsit_import_po_isn_dtl (
    raw_id bigint NOT NULL,
    wms_isn_ou integer,
    wms_isn_loc character varying(10) COLLATE public.nocase,
    wms_isn_po_no character varying(50) COLLATE public.nocase,
    wms_isn_sku_line_no integer,
    wms_isn_sku character varying(59) COLLATE public.nocase,
    wms_isn_sku_qty numeric,
    wms_isn_line_no character varying(10) COLLATE public.nocase,
    wms_isn_no character varying(50) COLLATE public.nocase,
    wms_isn_qty character varying(50) COLLATE public.nocase,
    wms_isn_createby character varying(100) COLLATE public.nocase,
    wms_isn_createddate timestamp without time zone,
    wms_isn_modifiedby character varying(100) COLLATE public.nocase,
    wms_isn_modifieddate timestamp without time zone,
    wms_asn_no character varying(100) COLLATE public.nocase,
    cancelflag character varying(10) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);