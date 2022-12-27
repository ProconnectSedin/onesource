CREATE TABLE raw.raw_not_notes_hdr (
    raw_id bigint NOT NULL,
    tran_no character varying(512) COLLATE public.nocase,
    tran_type character varying(512) NOT NULL COLLATE public.nocase,
    tran_ou integer NOT NULL,
    amendment_no integer,
    keyfield1 character varying(512) COLLATE public.nocase,
    keyfield2 character varying(512) COLLATE public.nocase,
    keyfield3 integer,
    keyfield4 integer,
    notes_compkey character varying(1020) NOT NULL COLLATE public.nocase,
    doc_attach_compkey character varying(1020) NOT NULL COLLATE public.nocase,
    doc_notes character varying COLLATE public.nocase,
    "timestamp" integer NOT NULL,
    created_by character varying(120) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(120) COLLATE public.nocase,
    modified_date timestamp without time zone,
    doc_db character varying(1000) COLLATE public.nocase,
    doc_file character varying(1000) COLLATE public.nocase,
    doc_desc character varying(1020) COLLATE public.nocase,
    doc_db_desc character varying COLLATE public.nocase,
    folder character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_not_notes_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_not_notes_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_not_notes_hdr
    ADD CONSTRAINT raw_not_notes_hdr_pkey PRIMARY KEY (raw_id);