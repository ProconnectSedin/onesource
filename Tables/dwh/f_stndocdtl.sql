-- Table: dwh.f_stndocdtl

-- DROP TABLE IF EXISTS dwh.f_stndocdtl;

CREATE TABLE IF NOT EXISTS dwh.f_stndocdtl
(
    stndocdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    stndocdtl_datekey bigint NOT NULL,
    ou_id integer,
    trns_debit_note character varying(40) COLLATE public.nocase,
    tran_type character varying(20) COLLATE public.nocase,
    dr_doc_no character varying(40) COLLATE public.nocase,
    ref_tran_type character varying(20) COLLATE public.nocase,
    dr_doc_ou integer,
    dr_doc_type character varying(20) COLLATE public.nocase,
    au_doc_date timestamp without time zone,
    au_supp_area integer,
    au_document_amount numeric(13,2),
    transfer_status character varying(10) COLLATE public.nocase,
    exchange_rate numeric(13,2),
    batch_id character varying(260) COLLATE public.nocase,
    drcr_flag character varying(20) COLLATE public.nocase,
    transfer_type character varying(30) COLLATE public.nocase,
    docamt numeric(13,2),
    docamt_parallelbase numeric(13,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_stndocdtl_pkey PRIMARY KEY (stndocdtl_key),
    CONSTRAINT f_stndocdtl_ukey UNIQUE (ou_id, trns_debit_note, dr_doc_no, ref_tran_type, dr_doc_ou)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_stndocdtl
    OWNER to proconnect;
-- Index: f_stndocdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_stndocdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_stndocdtl_key_idx
    ON dwh.f_stndocdtl USING btree
    (ou_id ASC NULLS LAST, trns_debit_note COLLATE public.nocase ASC NULLS LAST, dr_doc_no COLLATE public.nocase ASC NULLS LAST, ref_tran_type COLLATE public.nocase ASC NULLS LAST, dr_doc_ou ASC NULLS LAST)
    TABLESPACE pg_default;