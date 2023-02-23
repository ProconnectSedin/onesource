-- Table: dwh.f_stntransferbalhdr

-- DROP TABLE IF EXISTS dwh.f_stntransferbalhdr;

CREATE TABLE IF NOT EXISTS dwh.f_stntransferbalhdr
(
    stntransferbalhdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    acc_key bigint,
    datekey integer,
    ou_id integer,
    transfer_docno character varying(40) COLLATE public.nocase,
    transfer_date timestamp without time zone,
    batch_id character varying(260) COLLATE public.nocase,
    transfer_bal_in character varying(30) COLLATE public.nocase,
    transferor character varying(40) COLLATE public.nocase,
    auto_adjust character varying(10) COLLATE public.nocase,
    transferee character varying(40) COLLATE public.nocase,
    transferor_docno character varying(40) COLLATE public.nocase,
    transferor_doctype character varying(20) COLLATE public.nocase,
    transferee_docno character varying(40) COLLATE public.nocase,
    transferee_doctype character varying(20) COLLATE public.nocase,
    au_account_balance numeric(13,2),
    status character varying(10) COLLATE public.nocase,
    au_tran_amount numeric(13,2),
    au_account_code character varying(80) COLLATE public.nocase,
    transfer_bal_to character varying(30) COLLATE public.nocase,
    trasferor_acc_code character varying(80) COLLATE public.nocase,
    trasferee_acc_code character varying(80) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    modifiedby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifieddate timestamp without time zone,
    transferor_fb character varying(40) COLLATE public.nocase,
    transferor_curr character varying(10) COLLATE public.nocase,
    transferee_fb character varying(40) COLLATE public.nocase,
    transferee_curr character varying(10) COLLATE public.nocase,
    trans_type character varying(30) COLLATE public.nocase,
    consistency_stamp character varying(30) COLLATE public.nocase,
    workflow_status character varying(40) COLLATE public.nocase,
    destou integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_stntransferbalhdr_pkey PRIMARY KEY (stntransferbalhdr_key),
    CONSTRAINT f_stntransferbalhdr_ukey UNIQUE (ou_id, transfer_docno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_stntransferbalhdr
    OWNER to proconnect;
-- Index: f_stntransferbalhdr_key_idx

-- DROP INDEX IF EXISTS dwh.f_stntransferbalhdr_key_idx;

CREATE INDEX IF NOT EXISTS f_stntransferbalhdr_key_idx
    ON dwh.f_stntransferbalhdr USING btree
    (ou_id ASC NULLS LAST, transfer_docno COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;