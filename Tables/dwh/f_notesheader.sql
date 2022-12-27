CREATE TABLE dwh.f_notesheader (
    notes_hdr_key bigint NOT NULL,
    tran_no character varying(256) COLLATE public.nocase,
    tran_type character varying(256) COLLATE public.nocase,
    tran_ou integer,
    amendment_no integer,
    keyfield1 character varying(256) COLLATE public.nocase,
    keyfield2 character varying(256) COLLATE public.nocase,
    keyfield3 integer,
    keyfield4 integer,
    notes_compkey character varying(510) COLLATE public.nocase,
    doc_attach_compkey character varying(510) COLLATE public.nocase,
    doc_notes character varying(510) COLLATE public.nocase,
    time_stamp integer,
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    doc_db character varying(500) COLLATE public.nocase,
    doc_file character varying(500) COLLATE public.nocase,
    doc_desc character varying(510) COLLATE public.nocase,
    doc_db_desc character varying(500) COLLATE public.nocase,
    folder character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_notesheader ALTER COLUMN notes_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_notesheader_notes_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_notesheader
    ADD CONSTRAINT f_notesheader_pkey PRIMARY KEY (notes_hdr_key);

ALTER TABLE ONLY dwh.f_notesheader
    ADD CONSTRAINT f_notesheader_ukey UNIQUE (notes_compkey);

CREATE INDEX f_notesheader_key_idx ON dwh.f_notesheader USING btree (notes_compkey);