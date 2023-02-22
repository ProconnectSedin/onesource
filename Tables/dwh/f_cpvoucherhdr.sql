-- Table: dwh.f_cpvoucherhdr

-- DROP TABLE IF EXISTS dwh.f_cpvoucherhdr;

CREATE TABLE IF NOT EXISTS dwh.f_cpvoucherhdr
(
    cpvoucherhdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    cpvoucherhdr_customer_key bigint NOT NULL,
    account_code_key bigint NOT NULL,
    ou_id integer,
    voucher_no character varying(40) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    "timestamp" integer,
    pay_cat character varying(80) COLLATE public.nocase,
    req_date timestamp without time zone,
    business_unit character varying(40) COLLATE public.nocase,
    num_type character varying(20) COLLATE public.nocase,
    cus_reg_at integer,
    cus_code character varying(36) COLLATE public.nocase,
    pay_date timestamp without time zone,
    pay_method character varying(50) COLLATE public.nocase,
    pay_mode character varying(60) COLLATE public.nocase,
    pay_route character varying(60) COLLATE public.nocase,
    pay_cur character varying(10) COLLATE public.nocase,
    exch_rate numeric(13,2),
    pay_amount numeric(13,2),
    bank_cash_code character varying(64) COLLATE public.nocase,
    doc_ref character varying(36) COLLATE public.nocase,
    priority character varying(24) COLLATE public.nocase,
    billing_pt integer,
    relpay_pt integer,
    el_pay character varying(24) COLLATE public.nocase,
    elec_pay_applied character varying(24) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    revreason_code character varying(20) COLLATE public.nocase,
    rev_date timestamp without time zone,
    status character varying(50) COLLATE public.nocase,
    batch_id character varying(256) COLLATE public.nocase,
    pay_amt_bef_round numeric(13,2),
    roundoff_amt numeric(13,2),
    hldrev_remarks character varying(200) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_status character varying(24) COLLATE public.nocase,
    tcal_exclusive_amt numeric(13,2),
    acc_type character varying(20) COLLATE public.nocase,
    cust_account_code character varying(64) COLLATE public.nocase,
    adjustment character varying(80) COLLATE public.nocase,
    final_settlement character varying(6) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_cpvoucherhdr_pkey PRIMARY KEY (cpvoucherhdr_key),
    CONSTRAINT f_cpvoucherhdr_ukey UNIQUE (ou_id, voucher_no, tran_type),
    CONSTRAINT f_cpvoucherhdr_account_code_key_fkey FOREIGN KEY (account_code_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_cpvoucherhdr_cpvoucherhdr_customer_key_fkey FOREIGN KEY (cpvoucherhdr_customer_key)
        REFERENCES dwh.d_customer (customer_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cpvoucherhdr
    OWNER to proconnect;
-- Index: f_cpvoucherhdr_key_idx1

-- DROP INDEX IF EXISTS dwh.f_cpvoucherhdr_key_idx1;

CREATE INDEX IF NOT EXISTS f_cpvoucherhdr_key_idx1
    ON dwh.f_cpvoucherhdr USING btree
    (ou_id ASC NULLS LAST, voucher_no COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;