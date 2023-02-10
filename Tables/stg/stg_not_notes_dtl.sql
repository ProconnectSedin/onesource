-- Table: stg.stg_not_notes_dtl

-- DROP TABLE IF EXISTS stg.stg_not_notes_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_not_notes_dtl
(
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
    etlcreatedatetime timestamp(3) without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_not_notes_dtl
    OWNER to proconnect;
-- Index: stg_not_notes_dtl_idx

-- DROP INDEX IF EXISTS stg.stg_not_notes_dtl_idx;

CREATE INDEX IF NOT EXISTS stg_not_notes_dtl_idx
    ON stg.stg_not_notes_dtl USING btree
    (notes_compkey COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST, line_entity COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: stg_not_notes_dtl_idx1

-- DROP INDEX IF EXISTS stg.stg_not_notes_dtl_idx1;

CREATE INDEX IF NOT EXISTS stg_not_notes_dtl_idx1
    ON stg.stg_not_notes_dtl USING btree
    (notes_compkey COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;