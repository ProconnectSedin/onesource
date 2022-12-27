CREATE TABLE raw.raw_not_notes_dtl (
    raw_id bigint NOT NULL,
    tran_no character varying(512) NOT NULL COLLATE public.nocase,
    tran_type character varying(512) NOT NULL COLLATE public.nocase,
    tran_ou integer NOT NULL,
    amendment_no integer,
    keyfield1 character varying(512) COLLATE public.nocase,
    keyfield2 character varying(512) COLLATE public.nocase,
    keyfield3 integer,
    keyfield4 integer,
    notes_compkey character varying(1020) NOT NULL COLLATE public.nocase,
    line_no integer NOT NULL,
    line_entity character varying(1000) NOT NULL COLLATE public.nocase,
    line_notes character varying COLLATE public.nocase,
    line_df character varying(1000) COLLATE public.nocase,
    line_file character varying(1000) COLLATE public.nocase,
    line_desc character varying(1020) COLLATE public.nocase,
    line_df_desc character varying COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_not_notes_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_not_notes_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_not_notes_dtl
    ADD CONSTRAINT raw_not_notes_dtl_pkey PRIMARY KEY (raw_id);