CREATE TABLE raw.raw_wms_outbound_doc_detail (
    raw_id bigint NOT NULL,
    wms_oub_doc_loc_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_oub_outbound_ord character varying(1020) NOT NULL COLLATE public.nocase,
    wms_oub_doc_lineno integer NOT NULL,
    wms_oub_doc_ou integer NOT NULL,
    wms_oub_doc_type character varying(160) COLLATE public.nocase,
    wms_oub_doc_attach character varying(1020) COLLATE public.nocase,
    wms_oub_doc_hdn_attach character varying COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);