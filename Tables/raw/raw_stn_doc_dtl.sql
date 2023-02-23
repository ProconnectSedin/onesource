-- Table: raw.raw_stn_doc_dtl

-- DROP TABLE IF EXISTS "raw".raw_stn_doc_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_stn_doc_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT stn_doc_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_stn_doc_dtl
    OWNER to proconnect;