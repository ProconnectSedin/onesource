CREATE TABLE stg.stg_not_notes_attachdoc (
    sequence_no integer NOT NULL,
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
    natimestamp integer NOT NULL,
    created_by character varying(120) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(120) COLLATE public.nocase,
    modified_date timestamp without time zone,
    line_no integer NOT NULL,
    line_entity character varying(1000) NOT NULL COLLATE public.nocase,
    attach_file character varying(1000) COLLATE public.nocase,
    attach_df character varying(1000) COLLATE public.nocase,
    attached_on timestamp without time zone,
    attach_desc character varying(1020) COLLATE public.nocase,
    notes_comments character varying(10000) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_not_notes_attachdoc
    ADD CONSTRAINT pk__not_note__61fd609002277387 PRIMARY KEY (sequence_no, notes_compkey, line_no, line_entity);