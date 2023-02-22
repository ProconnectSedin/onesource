-- Table: dwh.f_ctrnacctinfo

-- DROP TABLE IF EXISTS dwh.f_ctrnacctinfo;

CREATE TABLE IF NOT EXISTS dwh.f_ctrnacctinfo
(
    ctrnacctinfo_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    account_code_key bigint NOT NULL,
    ctrnacctinfo_customer_key bigint NOT NULL,
    ctrnacctinfo_currency_key bigint NOT NULL,
    tran_type character varying(80) COLLATE public.nocase,
    tran_no character varying(36) COLLATE public.nocase,
    transfer_doc_no character varying(36) COLLATE public.nocase,
    acc_code character varying(64) COLLATE public.nocase,
    drcr_flag character varying(12) COLLATE public.nocase,
    acc_type character varying(80) COLLATE public.nocase,
    "timestamp" integer,
    fb_id character varying(40) COLLATE public.nocase,
    fin_post_date timestamp without time zone,
    currency character varying(10) COLLATE public.nocase,
    customer_code character varying(36) COLLATE public.nocase,
    tran_amt numeric(13,2),
    base_cur_exrate numeric(13,2),
    base_amt numeric(13,2),
    par_base_cur_exrate numeric(13,2),
    par_base_amt numeric(13,2),
    status character varying(50) COLLATE public.nocase,
    batch_id character varying(256) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    hdrremarks character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_ctrnacctinfo_pkey PRIMARY KEY (ctrnacctinfo_key),
    CONSTRAINT f_ctrnacctinfo_ukey UNIQUE (ou_id, tran_type, tran_no, transfer_doc_no, acc_code, drcr_flag, acc_type),
    CONSTRAINT f_ctrnacctinfo_account_code_key_fkey FOREIGN KEY (account_code_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_ctrnacctinfo_ctrnacctinfo_currency_key_fkey FOREIGN KEY (ctrnacctinfo_currency_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_ctrnacctinfo_ctrnacctinfo_customer_key_fkey FOREIGN KEY (ctrnacctinfo_customer_key)
        REFERENCES dwh.d_customer (customer_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_ctrnacctinfo
    OWNER to proconnect;
-- Index: f_ctrnacctinfo_key_idx1

-- DROP INDEX IF EXISTS dwh.f_ctrnacctinfo_key_idx1;

CREATE INDEX IF NOT EXISTS f_ctrnacctinfo_key_idx1
    ON dwh.f_ctrnacctinfo USING btree
    (ou_id ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, transfer_doc_no COLLATE public.nocase ASC NULLS LAST, acc_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST, acc_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;