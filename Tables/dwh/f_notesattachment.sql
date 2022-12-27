CREATE TABLE dwh.f_notesattachment (
    note_atch_key bigint NOT NULL,
    sequence_no integer,
    tran_no character varying(260) COLLATE public.nocase,
    tran_type character varying(260) COLLATE public.nocase,
    tran_ou integer,
    amendment_no integer,
    keyfield1 character varying(260) COLLATE public.nocase,
    keyfield2 character varying(260) COLLATE public.nocase,
    keyfield3 integer,
    keyfield4 integer,
    notes_compkey character varying(510) COLLATE public.nocase,
    doc_attach_compkey character varying(510) COLLATE public.nocase,
    natimestamp integer,
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    line_no integer,
    line_entity character varying(500) COLLATE public.nocase,
    attach_file character varying(500) COLLATE public.nocase,
    attach_df character varying(500) COLLATE public.nocase,
    attached_on timestamp without time zone,
    attach_desc character varying(510) COLLATE public.nocase,
    notes_comments character varying(5000) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_notesattachment ALTER COLUMN note_atch_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_notesattachment_note_atch_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_notesattachment
    ADD CONSTRAINT f_notesattachment_pkey PRIMARY KEY (note_atch_key);

ALTER TABLE ONLY dwh.f_notesattachment
    ADD CONSTRAINT f_notesattachment_ukey UNIQUE (sequence_no, notes_compkey, line_no, line_entity);