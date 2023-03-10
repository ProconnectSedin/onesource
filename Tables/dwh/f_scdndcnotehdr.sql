CREATE TABLE dwh.f_scdndcnotehdr (
    f_scdndcnotehdr_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    s_timestamp integer,
    supp_code character varying(40) COLLATE public.nocase,
    tran_status character varying(10) COLLATE public.nocase,
    note_type character varying(10) COLLATE public.nocase,
    note_cat character varying(10) COLLATE public.nocase,
    num_type character varying(20) COLLATE public.nocase,
    tran_date timestamp without time zone,
    anchor_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    tran_currency character varying(10) COLLATE public.nocase,
    exchange_rate numeric(25,2),
    pay_term character varying(30) COLLATE public.nocase,
    payterm_version integer,
    elec_pay character varying(10) COLLATE public.nocase,
    pay_mode character varying(50) COLLATE public.nocase,
    pay_method character varying(60) COLLATE public.nocase,
    pay_priority character varying(30) COLLATE public.nocase,
    payment_ou integer,
    supp_ou integer,
    supp_note_no character varying(200) COLLATE public.nocase,
    supp_note_date timestamp without time zone,
    supp_note_amount numeric(13,2),
    s_comments character varying(512) COLLATE public.nocase,
    tran_amount numeric(25,2),
    par_exchange_rate numeric(25,2),
    base_amount numeric(25,2),
    par_base_amount numeric(25,2),
    rev_doc_no character varying(40) COLLATE public.nocase,
    rev_doc_ou integer,
    rev_date timestamp without time zone,
    ref_doc_no character varying(40) COLLATE public.nocase,
    ref_doc_ou integer,
    rev_reason_code character varying(20) COLLATE public.nocase,
    rev_remarks character varying(510) COLLATE public.nocase,
    auth_date timestamp without time zone,
    disc_comp_basis character varying(10) COLLATE public.nocase,
    discount_proportional character varying(10) COLLATE public.nocase,
    pre_round_off_amount numeric(25,2),
    rounded_off_amount numeric(25,2),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    batch_id character varying(300) COLLATE public.nocase,
    tcal_status character varying(30) COLLATE public.nocase,
    tcal_exclusive_amount numeric(25,2),
    tcal_total_amount numeric(25,2),
    autogen_flag character varying(30) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    ibe_flag character varying(30) COLLATE public.nocase,
    auto_adjust character varying(30) COLLATE public.nocase,
    ict_flag character varying(30) COLLATE public.nocase,
    mail_sent character varying(50) COLLATE public.nocase,
    supplieraddress character varying(510) COLLATE public.nocase,
    ifb_flag character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_scdndcnotehdr ALTER COLUMN f_scdndcnotehdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_scdndcnotehdr_f_scdndcnotehdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_scdndcnotehdr
    ADD CONSTRAINT f_scdndcnotehdr_pkey PRIMARY KEY (f_scdndcnotehdr_key);

ALTER TABLE ONLY dwh.f_scdndcnotehdr
    ADD CONSTRAINT f_scdndcnotehdr_ukey UNIQUE (tran_type, tran_ou, tran_no, ict_flag, ifb_flag);

CREATE INDEX f_scdndcnotehdr_key_idx ON dwh.f_scdndcnotehdr USING btree (tran_type, tran_ou, tran_no, ict_flag, ifb_flag);