CREATE TABLE raw.raw_wms_dispatch_hdr (
    raw_id bigint NOT NULL,
    wms_dispatch_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_dispatch_ld_sheet_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_dispatch_ld_sheet_ou integer NOT NULL,
    wms_dispatch_ld_sheet_date timestamp without time zone,
    wms_dispatch_ld_sheet_status character varying(32) COLLATE public.nocase,
    wms_dispatch_staging_id character varying(72) COLLATE public.nocase,
    wms_dispatch_lsp character varying(160) COLLATE public.nocase,
    wms_dispatch_source_stage character varying(1020) COLLATE public.nocase,
    wms_dispatch_source_docno character varying(72) COLLATE public.nocase,
    wms_dispatch_created_by character varying(120) COLLATE public.nocase,
    wms_dispatch_created_date timestamp without time zone,
    wms_dispatch_modified_by character varying(120) COLLATE public.nocase,
    wms_dispatch_modified_date timestamp without time zone,
    wms_dispatch_timestamp integer,
    wms_dispatch_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_dispatch_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_dispatch_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_dispatch_booking_req_no character varying(72) COLLATE public.nocase,
    wms_pack_disp_urgent integer,
    wms_dispatch_doc_code character varying(72) COLLATE public.nocase,
    wms_dispatch_vehicle_code character varying(72) COLLATE public.nocase,
    wms_dispatch_reason_code character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_dispatch_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_dispatch_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_dispatch_hdr
    ADD CONSTRAINT raw_wms_dispatch_hdr_pkey PRIMARY KEY (raw_id);