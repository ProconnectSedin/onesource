CREATE TABLE dwh.f_jvvouchertrndtl (
    jv_vcr_trn_dtl_key bigint NOT NULL,
    ou_id integer,
    voucher_no character varying(40) COLLATE public.nocase,
    voucher_serial_no integer,
    "timestamp" integer,
    account_code character varying(80) COLLATE public.nocase,
    drcr_flag character varying(20) COLLATE public.nocase,
    tran_currency character varying(10) COLLATE public.nocase,
    tran_amount numeric(20,2),
    exchange_rate numeric(20,2),
    par_exchange_rate numeric(20,2),
    base_amount numeric(20,2),
    par_base_amount numeric(20,2),
    remarks character varying(510) COLLATE public.nocase,
    costcenter_code character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanal_code character varying(10) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    destfbid character varying(40) COLLATE public.nocase,
    destaccountcode character varying(80) COLLATE public.nocase,
    intercompjv character varying(40) COLLATE public.nocase,
    dest_cost_center character varying(20) COLLATE public.nocase,
    account_currency character varying(10) COLLATE public.nocase,
    base_erate_inacccur numeric(20,2),
    des_ouid integer,
    revintercompjv character varying(40) COLLATE public.nocase,
    usage_id character varying(40) COLLATE public.nocase,
    guid1 character varying(300) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_jvvouchertrndtl ALTER COLUMN jv_vcr_trn_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_jvvouchertrndtl_jv_vcr_trn_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_jvvouchertrndtl
    ADD CONSTRAINT f_jvvouchertrndtl_pkey PRIMARY KEY (jv_vcr_trn_dtl_key);

ALTER TABLE ONLY dwh.f_jvvouchertrndtl
    ADD CONSTRAINT f_jvvouchertrndtl_ukey UNIQUE (ou_id, voucher_no, voucher_serial_no);