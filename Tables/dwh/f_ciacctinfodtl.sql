-- Table: dwh.f_ciacctinfodtl

-- DROP TABLE IF EXISTS dwh.f_ciacctinfodtl;

CREATE TABLE IF NOT EXISTS dwh.f_ciacctinfodtl
(
    ci_acct_info_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ciacctinfodtl_company_key bigint NOT NULL,
    ciacctinfodtl_opcoa_key bigint NOT NULL,
    ciacctinfodtl_date_key bigint NOT NULL,
    ciacctinfodtl_itm_hdr_key bigint NOT NULL,
    ciacctinfodtl_curr_key bigint NOT NULL,
    tran_ou integer,
    tran_type character varying(20) COLLATE public.nocase,
    tran_no character varying(36) COLLATE public.nocase,
    component_id character varying(32) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    account_code character varying(64) COLLATE public.nocase,
    drcr_flag character varying(12) COLLATE public.nocase,
    line_no integer,
    batch_id character varying(256) COLLATE public.nocase,
    lo_id character varying(40) COLLATE public.nocase,
    txnou_id integer,
    bu_id character varying(40) COLLATE public.nocase,
    tran_date timestamp without time zone,
    tran_amount_acc_cur numeric(25,2),
    ctrl_acct_type character varying(30) COLLATE public.nocase,
    auto_post_acct_type character varying(30) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    item_code character varying(64) COLLATE public.nocase,
    item_variant character varying(64) COLLATE public.nocase,
    uom character varying(30) COLLATE public.nocase,
    supcust_code character varying(36) COLLATE public.nocase,
    acct_currency character varying(10) COLLATE public.nocase,
    basecur_erate numeric(25,2),
    base_amount numeric(25,2),
    par_exchange_rate numeric(25,2),
    par_base_amount numeric(25,2),
    auth_date timestamp without time zone,
    ref_doc_no character varying(36) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    posting_date timestamp without time zone,
    base_currency character varying(10) COLLATE public.nocase,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    vat_posting_flag character varying(2) COLLATE public.nocase,
    account_type character varying(30) COLLATE public.nocase,
    ref_doc_lineno integer,
    ibe_flag character varying(24) COLLATE public.nocase,
    fbp_post_flag character varying(24) COLLATE public.nocase,
    fin_year character varying(30) COLLATE public.nocase,
    fin_period character varying(30) COLLATE public.nocase,
    hdrremarks character varying(512) COLLATE public.nocase,
    mlremarks character varying(510) COLLATE public.nocase,
    instr_no character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_ciacctinfodtl_pkey PRIMARY KEY (ci_acct_info_dtl_key),
    CONSTRAINT f_ciacctinfodtl_ukey UNIQUE (tran_ou, tran_type, tran_no, component_id, company_code, fb_id, account_code, drcr_flag, line_no),
    CONSTRAINT f_ciacctinfodtl_ciacctinfodtl_company_key_fkey FOREIGN KEY (ciacctinfodtl_company_key)
        REFERENCES dwh.d_company (company_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_ciacctinfodtl_ciacctinfodtl_curr_key_fkey FOREIGN KEY (ciacctinfodtl_curr_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_ciacctinfodtl_ciacctinfodtl_date_key_fkey FOREIGN KEY (ciacctinfodtl_date_key)
        REFERENCES dwh.d_date (datekey) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_ciacctinfodtl_ciacctinfodtl_itm_hdr_key_fkey FOREIGN KEY (ciacctinfodtl_itm_hdr_key)
        REFERENCES dwh.d_itemheader (itm_hdr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_ciacctinfodtl_ciacctinfodtl_opcoa_key_fkey FOREIGN KEY (ciacctinfodtl_opcoa_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_ciacctinfodtl
    OWNER to proconnect;