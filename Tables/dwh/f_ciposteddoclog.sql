-- Table: dwh.f_ciposteddoclog

-- DROP TABLE IF EXISTS dwh.f_ciposteddoclog;

CREATE TABLE IF NOT EXISTS dwh.f_ciposteddoclog
(
    ciposteddoclog_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    cipostdoc_cust_key bigint NOT NULL,
    account_code_key bigint NOT NULL,
    tran_ou integer,
    tran_type character varying(20) COLLATE public.nocase,
    tran_no character varying(36) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    amt_type character varying(20) COLLATE public.nocase,
    ref_doc_ou integer,
    ref_doc_type character varying(20) COLLATE public.nocase,
    ref_doc_no character varying(36) COLLATE public.nocase,
    ref_doc_term character varying(40) COLLATE public.nocase,
    adjd_doc_ou integer,
    adjd_doc_type character varying(20) COLLATE public.nocase,
    adjd_doc_no character varying(36) COLLATE public.nocase,
    adjd_doc_term character varying(40) COLLATE public.nocase,
    createddate timestamp without time zone,
    "timestamp" integer,
    lo_id character varying(40) COLLATE public.nocase,
    batch_id character varying(256) COLLATE public.nocase,
    tran_date timestamp without time zone,
    cust_code character varying(36) COLLATE public.nocase,
    tran_currency character varying(10) COLLATE public.nocase,
    tran_amount numeric(20,2),
    basecur_erate numeric(20,2),
    base_amount numeric(20,2),
    par_exchange_rate numeric(20,2),
    par_base_amount numeric(20,2),
    ref_doc_date timestamp without time zone,
    ref_doc_cur character varying(10) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    posting_status character varying(2) COLLATE public.nocase,
    posting_date timestamp without time zone,
    adjust_amount_inv_cur numeric(20,2),
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    account_code character varying(64) COLLATE public.nocase,
    account_type character varying(30) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    discount_amount numeric(20,2),
    penalty_amount numeric(20,2),
    writeoff_amount numeric(20,2),
    received_amount numeric(20,2),
    doc_status character varying(50) COLLATE public.nocase,
    receipt_type character varying(50) COLLATE public.nocase,
    base_adjust_amt numeric(20,2),
    pbase_adjust_amt numeric(20,2),
    base_received_amount numeric(20,2),
    pbase_received_amount numeric(20,2),
    base_writeoff_amount numeric(20,2),
    pbase_writeoff_amount numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_ciposteddoclog_pkey PRIMARY KEY (ciposteddoclog_key),
    CONSTRAINT f_ciposteddoclog_ukey UNIQUE (tran_ou, tran_type, tran_no, term_no, amt_type, ref_doc_ou, ref_doc_type, ref_doc_no, ref_doc_term, adjd_doc_ou, adjd_doc_type, adjd_doc_no, adjd_doc_term, createddate, account_type),
    CONSTRAINT f_ciposteddoclog_account_code_key_fkey FOREIGN KEY (account_code_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_ciposteddoclog_cipostdoc_cust_key_fkey FOREIGN KEY (cipostdoc_cust_key)
        REFERENCES dwh.d_customer (customer_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_ciposteddoclog
    OWNER to proconnect;
-- Index: f_ciposteddoclog_key_idx1

-- DROP INDEX IF EXISTS dwh.f_ciposteddoclog_key_idx1;

CREATE INDEX IF NOT EXISTS f_ciposteddoclog_key_idx1
    ON dwh.f_ciposteddoclog USING btree
    (tran_ou ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST, amt_type COLLATE public.nocase ASC NULLS LAST, ref_doc_ou ASC NULLS LAST, ref_doc_type COLLATE public.nocase ASC NULLS LAST, ref_doc_no COLLATE public.nocase ASC NULLS LAST, ref_doc_term COLLATE public.nocase ASC NULLS LAST, adjd_doc_ou ASC NULLS LAST, adjd_doc_type COLLATE public.nocase ASC NULLS LAST, adjd_doc_no COLLATE public.nocase ASC NULLS LAST, adjd_doc_term COLLATE public.nocase ASC NULLS LAST, createddate ASC NULLS LAST, account_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;