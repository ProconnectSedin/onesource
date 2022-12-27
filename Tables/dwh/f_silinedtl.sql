CREATE TABLE dwh.f_silinedtl (
    si_line_dtl_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    line_no integer,
    row_type character varying(30) COLLATE public.nocase,
    lo_id character varying(40) COLLATE public.nocase,
    ref_doc_type character varying(20) COLLATE public.nocase,
    ref_doc_ou integer,
    ref_doc_no character varying(40) COLLATE public.nocase,
    ref_doc_term_no character varying(40) COLLATE public.nocase,
    item_tcd_code character varying(80) COLLATE public.nocase,
    item_tcd_var character varying(80) COLLATE public.nocase,
    uom character varying(30) COLLATE public.nocase,
    item_qty numeric(13,2),
    unit_price numeric(13,2),
    rate_per numeric(13,2),
    item_amount numeric(13,2),
    tax_amount numeric(13,2),
    disc_amount numeric(13,2),
    line_amount numeric(13,2),
    capitalized_amount numeric(13,2),
    proposal_no character varying(40) COLLATE public.nocase,
    cap_doc_flag character varying(30) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    usage_id character varying(40) COLLATE public.nocase,
    pending_cap_amount numeric(13,2),
    account_code character varying(80) COLLATE public.nocase,
    milestone_code character varying(80) COLLATE public.nocase,
    report_flag character varying(10) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_silinedtl ALTER COLUMN si_line_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_silinedtl_si_line_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_silinedtl
    ADD CONSTRAINT f_silinedtl_pkey PRIMARY KEY (si_line_dtl_key);

ALTER TABLE ONLY dwh.f_silinedtl
    ADD CONSTRAINT f_silinedtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no, row_type, ref_doc_no);

CREATE INDEX f_silinedtl_key_idx ON dwh.f_silinedtl USING btree (tran_type, tran_ou, tran_no, line_no, ref_doc_no, row_type);