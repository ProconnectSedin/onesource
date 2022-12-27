CREATE TABLE dwh.f_surreceipthdr (
    surreceipthdr_key bigint NOT NULL,
    surreceipthdr_curr_key bigint NOT NULL,
    surreceipthdr_datekey bigint NOT NULL,
    ou_id integer,
    receipt_no character varying(40) COLLATE public.nocase,
    receipt_type character varying(10) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    stimestamp integer,
    receipt_date timestamp without time zone,
    receipt_category character varying(10) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    notype_no character varying(20) COLLATE public.nocase,
    remitter_name character varying(120) COLLATE public.nocase,
    receipt_method character varying(60) COLLATE public.nocase,
    receipt_mode character varying(10) COLLATE public.nocase,
    receipt_route character varying(10) COLLATE public.nocase,
    bank_cash_code character varying(80) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    exchange_rate numeric(25,2),
    receipt_amount numeric(25,2),
    origin_no character varying(40) COLLATE public.nocase,
    reason_code character varying(20) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    instr_no character varying(60) COLLATE public.nocase,
    micr_no character varying(60) COLLATE public.nocase,
    instr_amount numeric(25,2),
    instr_date timestamp without time zone,
    instr_status character varying(10) COLLATE public.nocase,
    bank_code character varying(80) COLLATE public.nocase,
    receipt_status character varying(10) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    refdoc_no character varying(40) COLLATE public.nocase,
    refdoc_type character varying(80) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_exclusive_amt numeric(25,2),
    total_tcal_amount numeric(25,2),
    tcal_status character varying(30) COLLATE public.nocase,
    acct_type character varying(30) COLLATE public.nocase,
    insamt_btcal numeric(25,2),
    refdoc_ou integer,
    instr_type character varying(50) COLLATE public.nocase,
    auto_gen_flag character varying(30) COLLATE public.nocase,
    afe_number character varying(40) COLLATE public.nocase,
    job_number character varying(40) COLLATE public.nocase,
    report_flag character varying(20) COLLATE public.nocase,
    ifb_flag character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_surreceipthdr ALTER COLUMN surreceipthdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_surreceipthdr_surreceipthdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_surreceipthdr
    ADD CONSTRAINT f_surreceipthdr_pkey PRIMARY KEY (surreceipthdr_key);

ALTER TABLE ONLY dwh.f_surreceipthdr
    ADD CONSTRAINT f_surreceipthdr_ukey UNIQUE (ou_id, receipt_no, receipt_type, tran_type, stimestamp, ifb_flag);

ALTER TABLE ONLY dwh.f_surreceipthdr
    ADD CONSTRAINT f_surreceipthdr_surreceipthdr_curr_key_fkey FOREIGN KEY (surreceipthdr_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_surreceipthdr
    ADD CONSTRAINT f_surreceipthdr_surreceipthdr_date_key_fkey FOREIGN KEY (surreceipthdr_datekey) REFERENCES dwh.d_date(datekey);

CREATE INDEX f_surreceipthdr_key_idx ON dwh.f_surreceipthdr USING btree (ou_id, receipt_no, receipt_type, tran_type, stimestamp, ifb_flag);

CREATE INDEX f_surreceipthdr_key_idx1 ON dwh.f_surreceipthdr USING btree (surreceipthdr_curr_key, surreceipthdr_datekey);