-- Table: raw.raw_not_notes_dtl

-- DROP TABLE IF EXISTS "raw".raw_not_notes_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_not_notes_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    etlcreatedatetime timestamp(3) without time zone,
    CONSTRAINT raw_not_notes_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_not_notes_dtl
    OWNER to proconnect;