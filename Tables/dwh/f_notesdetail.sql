-- Table: dwh.f_notesdetail

-- DROP TABLE IF EXISTS dwh.f_notesdetail;

CREATE TABLE IF NOT EXISTS dwh.f_notesdetail
(
    notes_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    notes_hdr_key bigint NOT NULL,
    tran_no character varying(260) COLLATE public.nocase,
    tran_type character varying(260) COLLATE public.nocase,
    tran_ou integer,
    amendment_no integer,
    keyfield1 character varying(260) COLLATE public.nocase,
    keyfield2 character varying(260) COLLATE public.nocase,
    keyfield3 integer,
    keyfield4 integer,
    notes_compkey character varying(510) COLLATE public.nocase,
    line_no integer,
    line_entity character varying(500) COLLATE public.nocase,
    line_notes character varying(2000) COLLATE public.nocase,
    line_df character varying(500) COLLATE public.nocase,
    line_file character varying(500) COLLATE public.nocase,
    line_desc character varying(510) COLLATE public.nocase,
    line_df_desc character varying(2000) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_notesdetail_pkey PRIMARY KEY (notes_dtl_key),
    CONSTRAINT f_notesdetail_ukey UNIQUE (notes_compkey, line_no, line_entity)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_notesdetail
    OWNER to proconnect;
-- Index: f_notesdetail_key_idx

-- DROP INDEX IF EXISTS dwh.f_notesdetail_key_idx;

CREATE INDEX IF NOT EXISTS f_notesdetail_key_idx
    ON dwh.f_notesdetail USING btree
    (notes_compkey COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST, line_entity COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: f_notesdetail_key_idx1

-- DROP INDEX IF EXISTS dwh.f_notesdetail_key_idx1;

CREATE INDEX IF NOT EXISTS f_notesdetail_key_idx1
    ON dwh.f_notesdetail USING btree
    (notes_compkey COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;