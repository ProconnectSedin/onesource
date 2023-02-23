-- Table: raw.raw_stn_transfer_bal_hdr

-- DROP TABLE IF EXISTS "raw".raw_stn_transfer_bal_hdr;

CREATE TABLE IF NOT EXISTS "raw".raw_stn_transfer_bal_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    transfer_docno character varying(72) COLLATE public.nocase NOT NULL,
    transfer_date timestamp without time zone,
    batch_id character varying(512) COLLATE public.nocase,
    transfer_bal_in character varying(60) COLLATE public.nocase,
    transferor character varying(64) COLLATE public.nocase,
    auto_adjust character varying(20) COLLATE public.nocase,
    transferee character varying(64) COLLATE public.nocase,
    transferor_docno character varying(72) COLLATE public.nocase,
    transferor_doctype character varying(40) COLLATE public.nocase,
    transferee_docno character varying(72) COLLATE public.nocase,
    transferee_doctype character varying(40) COLLATE public.nocase,
    au_account_balance numeric,
    status character varying(8) COLLATE public.nocase,
    au_tran_amount numeric,
    au_account_code character varying(128) COLLATE public.nocase,
    transfer_bal_to character varying(60) COLLATE public.nocase,
    trasferor_acc_code character varying(128) COLLATE public.nocase,
    trasferee_acc_code character varying(128) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    modifiedby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifieddate timestamp without time zone,
    transferor_fb character varying(80) COLLATE public.nocase,
    transferor_curr character varying(20) COLLATE public.nocase,
    transferee_fb character varying(80) COLLATE public.nocase,
    transferee_curr character varying(20) COLLATE public.nocase,
    trans_type character varying(48) COLLATE public.nocase,
    consistency_stamp character varying(48) COLLATE public.nocase,
    workflow_status character varying(80) COLLATE public.nocase,
    destou integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_stn_transfer_bal_hdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_stn_transfer_bal_hdr
    OWNER to proconnect;