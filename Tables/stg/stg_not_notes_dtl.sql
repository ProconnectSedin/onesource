CREATE TABLE stg.stg_not_notes_dtl (
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

ALTER TABLE ONLY stg.stg_not_notes_dtl
    ADD CONSTRAINT pk__not_notes_dtl__409e6f85 PRIMARY KEY (notes_compkey, line_no, line_entity);