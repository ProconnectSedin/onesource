CREATE TABLE raw.raw_rct_purchase_hdr (
    raw_id bigint NOT NULL,
    rcgh_ouinstid integer NOT NULL,
    rcgh_receipt_no character varying(72) NOT NULL COLLATE public.nocase,
    rcgh_num_type_no character varying(40) NOT NULL COLLATE public.nocase,
    rcgh_wh_no character varying(40) NOT NULL COLLATE public.nocase,
    rcgh_ref_doc_no character varying(72) COLLATE public.nocase,
    rcgh_ref_doc_type character varying(40) COLLATE public.nocase,
    rcgh_po_no character varying(72) COLLATE public.nocase,
    rcgh_receipt_date timestamp without time zone NOT NULL,
    rcgh_purchase_point integer,
    rcgh_posting_fb character varying(80) COLLATE public.nocase,
    rcgh_status character(8) NOT NULL COLLATE public.nocase,
    rcgh_reason_code character varying(24) COLLATE public.nocase,
    rcgh_created_by character varying(120) NOT NULL COLLATE public.nocase,
    rcgh_created_date timestamp without time zone NOT NULL,
    rcgh_modified_by character varying(120) NOT NULL COLLATE public.nocase,
    rcgh_modified_date timestamp without time zone NOT NULL,
    rcgh_timestamp integer NOT NULL,
    process_flag character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_rct_purchase_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_rct_purchase_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_rct_purchase_hdr
    ADD CONSTRAINT raw_rct_purchase_hdr_pkey PRIMARY KEY (raw_id);