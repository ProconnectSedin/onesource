CREATE TABLE raw.raw_tms_dds_dispatch_document_signature (
    raw_id bigint NOT NULL,
    dds_ouinstance integer NOT NULL,
    dds_trip_id character varying(160) NOT NULL COLLATE public.nocase,
    dds_seqno integer NOT NULL,
    dds_dispatch_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    dds_name character varying(160) COLLATE public.nocase,
    dds_signature character varying COLLATE public.nocase,
    dds_remarks character varying(1024) COLLATE public.nocase,
    dds_feedback character varying(100) COLLATE public.nocase,
    dds_signature_status character varying(100) COLLATE public.nocase,
    dds_id_type character varying(160) COLLATE public.nocase,
    dds_id_no character varying(160) COLLATE public.nocase,
    dds_designation character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_dds_dispatch_document_signature ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_dds_dispatch_document_signature_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_dds_dispatch_document_signature
    ADD CONSTRAINT raw_tms_dds_dispatch_document_signature_pkey PRIMARY KEY (raw_id);