CREATE TABLE dwh.f_cidochdr (
    cid_hdr_key bigint NOT NULL,
    customer_key bigint NOT NULL,
    curr_key bigint NOT NULL,
    company_key bigint NOT NULL,
    fb_key bigint NOT NULL,
    tran_ou integer,
    tran_type character varying(20) COLLATE public.nocase,
    tran_no character varying(40) COLLATE public.nocase,
    ctimestamp integer,
    lo_id character varying(40) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    cust_code character varying(40) COLLATE public.nocase,
    tran_currency character varying(10) COLLATE public.nocase,
    tran_amount numeric(20,2),
    basecur_erate numeric(20,2),
    par_exchange_rate numeric(20,2),
    doc_status character varying(50) COLLATE public.nocase,
    instr_no character varying(60) COLLATE public.nocase,
    instr_date timestamp without time zone,
    instr_status character varying(50) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    pay_term character varying(30) COLLATE public.nocase,
    due_amount numeric(20,2),
    received_amount numeric(20,2),
    adjusted_amount numeric(20,2),
    discount_amount numeric(20,2),
    discount_availed numeric(20,2),
    penalty_amount numeric(20,2),
    write_off_amount numeric(20,2),
    write_back_amount numeric(20,2),
    paid_amount numeric(20,2),
    reversed_docno character varying(40) COLLATE public.nocase,
    reversal_date timestamp without time zone,
    adjustment_status character varying(50) COLLATE public.nocase,
    provision_amount_cm numeric(20,2),
    tran_date timestamp without time zone,
    company_code character varying(20) COLLATE public.nocase,
    ibe_flag character varying(30) COLLATE public.nocase,
    base_amount numeric(20,2),
    par_base_amount numeric(20,2),
    report_flag character varying(10) COLLATE public.nocase,
    realization_date timestamp without time zone,
    otc_flag character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_cidochdr ALTER COLUMN cid_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_cidochdr_cid_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_cidochdr
    ADD CONSTRAINT f_cidochdr_pkey PRIMARY KEY (cid_hdr_key);

ALTER TABLE ONLY dwh.f_cidochdr
    ADD CONSTRAINT f_cidochdr_ukey UNIQUE (tran_ou, tran_type, tran_no, ctimestamp);

CREATE INDEX f_cidochdr_key_idx ON dwh.f_cidochdr USING btree (customer_key, curr_key, company_key, fb_key);