CREATE TABLE dwh.f_ainqcwipaccountinginfo (
    f_ainqcwipaccountinginfo_key bigint NOT NULL,
    tran_ou integer,
    component_id character varying(340) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    asset_class character varying(40) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    tran_number character varying(40) COLLATE public.nocase,
    asset_number character varying(40) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    proposal_no character varying(40) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    account_type character varying(80) COLLATE public.nocase,
    drcr_flag character varying(20) COLLATE public.nocase,
    currency character varying(10) COLLATE public.nocase,
    tran_amount numeric(13,2),
    tran_date timestamp without time zone,
    posting_date timestamp without time zone,
    depr_book character varying(40) COLLATE public.nocase,
    bc_erate numeric(13,2),
    base_amount numeric(13,2),
    pbc_erate numeric(13,2),
    pbase_amount numeric(13,2),
    batch_id character varying(300) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    rpt_flag character varying(20) COLLATE public.nocase,
    rpt_amount numeric(13,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_ainqcwipaccountinginfo ALTER COLUMN f_ainqcwipaccountinginfo_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_ainqcwipaccountinginfo_f_ainqcwipaccountinginfo_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_ainqcwipaccountinginfo
    ADD CONSTRAINT f_ainqcwipaccountinginfo_pkey PRIMARY KEY (f_ainqcwipaccountinginfo_key);

ALTER TABLE ONLY dwh.f_ainqcwipaccountinginfo
    ADD CONSTRAINT f_ainqcwipaccountinginfo_ukey UNIQUE (tran_ou, component_id, company_code, tran_number, proposal_no);

CREATE INDEX f_ainqcwipaccountinginfo_key_idx ON dwh.f_ainqcwipaccountinginfo USING btree (tran_ou, component_id, company_code, tran_number, proposal_no);