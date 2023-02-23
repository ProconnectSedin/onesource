-- Table: stg.stg_stn_doc_dtl

-- DROP TABLE IF EXISTS stg.stg_stn_doc_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_stn_doc_dtl
(
    ou_id integer NOT NULL,
    trns_debit_note character varying(72) COLLATE public.nocase NOT NULL,
    tran_type character varying(40) COLLATE public.nocase NOT NULL,
    dr_doc_no character varying(72) COLLATE public.nocase NOT NULL,
    ref_tran_type character varying(40) COLLATE public.nocase NOT NULL,
    dr_doc_ou integer NOT NULL,
    dr_doc_type character varying(40) COLLATE public.nocase,
    au_doc_date timestamp without time zone,
    au_supp_area integer,
    au_document_amount numeric,
    transfer_status character varying(8) COLLATE public.nocase,
    exchange_rate numeric,
    batch_id character varying(512) COLLATE public.nocase,
    drcr_flag character varying(24) COLLATE public.nocase,
    transfer_type character varying(48) COLLATE public.nocase,
    docamt numeric,
    docamt_parallelbase numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT stn_doc_dtl_pkey PRIMARY KEY (ou_id, trns_debit_note, dr_doc_no, ref_tran_type, dr_doc_ou)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_stn_doc_dtl
    OWNER to proconnect;
-- Index: stg_stn_doc_dtl_key_idx

-- DROP INDEX IF EXISTS stg.stg_stn_doc_dtl_key_idx;

CREATE INDEX IF NOT EXISTS stg_stn_doc_dtl_key_idx
    ON stg.stg_stn_doc_dtl USING btree
    (ou_id ASC NULLS LAST, trns_debit_note COLLATE public.nocase ASC NULLS LAST, dr_doc_no COLLATE public.nocase ASC NULLS LAST, ref_tran_type COLLATE public.nocase ASC NULLS LAST, dr_doc_ou ASC NULLS LAST)
    TABLESPACE pg_default;