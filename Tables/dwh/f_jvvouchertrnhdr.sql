CREATE TABLE dwh.f_jvvouchertrnhdr (
    jv_vcr_trn_hdr_key bigint NOT NULL,
    ou_id integer,
    voucher_no character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    voucher_type character varying(40) COLLATE public.nocase,
    voucher_date timestamp without time zone,
    numbering_type character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    ref_voucher_no character varying(40) COLLATE public.nocase,
    ref_voucher_type character varying(40) COLLATE public.nocase,
    rev_year character varying(20) COLLATE public.nocase,
    rev_period character varying(20) COLLATE public.nocase,
    control_total numeric(20,2),
    remarks character varying(512) COLLATE public.nocase,
    voucher_status character varying(50) COLLATE public.nocase,
    authorised_by character varying(60) COLLATE public.nocase,
    authorised_date timestamp without time zone,
    base_amount numeric(20,2),
    component_id character varying(40) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_exclusive_amt numeric(20,2),
    total_tcal_amount numeric(20,2),
    tcal_status character varying(30) COLLATE public.nocase,
    auto_gen_flag character varying(30) COLLATE public.nocase,
    source_fbid character varying(40) COLLATE public.nocase,
    source_tran_no character varying(40) COLLATE public.nocase,
    source_tran_ou character varying(40) COLLATE public.nocase,
    source_tran_type character varying(80) COLLATE public.nocase,
    source_tran_date timestamp without time zone,
    costcenter_hdr character varying(20) COLLATE public.nocase,
    revsal_date timestamp without time zone,
    rev_remarks character varying(510) COLLATE public.nocase,
    ifb_usage character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_jvvouchertrnhdr ALTER COLUMN jv_vcr_trn_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_jvvouchertrnhdr_jv_vcr_trn_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_jvvouchertrnhdr
    ADD CONSTRAINT f_jvvouchertrnhdr_pkey PRIMARY KEY (jv_vcr_trn_hdr_key);

ALTER TABLE ONLY dwh.f_jvvouchertrnhdr
    ADD CONSTRAINT f_jvvouchertrnhdr_ukey UNIQUE (ou_id, voucher_no);