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

ALTER TABLE raw.raw_wms_outbound_doc_detail ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_outbound_doc_detail_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_outbound_doc_detail
    ADD CONSTRAINT raw_wms_outbound_doc_detail_pkey PRIMARY KEY (raw_id);