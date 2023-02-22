-- Table: dwh.f_stnacctinfodtl

-- DROP TABLE IF EXISTS dwh.f_stnacctinfodtl;

CREATE TABLE IF NOT EXISTS dwh.f_stnacctinfodtl
(
    stnacctinfodtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    account_code_key bigint NOT NULL,
    comp_code_key bigint NOT NULL,
    currency_key bigint NOT NULL,
    date_key bigint NOT NULL,
    supp_key bigint NOT NULL,
    ou_id character varying(30) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    tran_no character varying(36) COLLATE public.nocase,
    tran_type character varying(20) COLLATE public.nocase,
    account_code character varying(64) COLLATE public.nocase,
    drcr_flag character varying(12) COLLATE public.nocase,
    account_type character varying(30) COLLATE public.nocase,
    tran_date timestamp without time zone,
    fin_post_date timestamp without time zone,
    currency_code character varying(10) COLLATE public.nocase,
    tran_amount numeric(13,2),
    fb_id character varying(40) COLLATE public.nocase,
    basecur_erate numeric(13,2),
    base_amount numeric(13,2),
    pbcur_erate numeric(13,2),
    par_base_amt numeric(13,2),
    fin_post_status character varying(4) COLLATE public.nocase,
    guid character varying(256) COLLATE public.nocase,
    transfer_docno character varying(36) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    supplier_code character varying(32) COLLATE public.nocase,
    hdrremarks character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_stnacctinfodtl_pkey PRIMARY KEY (stnacctinfodtl_key),
    CONSTRAINT f_stnacctinfodtl_ukey UNIQUE (ou_id, company_code, tran_no, tran_type, account_code, drcr_flag, account_type),
    CONSTRAINT f_stnacctinfodtl_account_code_key_fkey FOREIGN KEY (account_code_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_stnacctinfodtl_comp_code_key_fkey FOREIGN KEY (comp_code_key)
        REFERENCES dwh.d_company (company_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_stnacctinfodtl_currency_key_fkey FOREIGN KEY (currency_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_stnacctinfodtl_date_key_fkey FOREIGN KEY (date_key)
        REFERENCES dwh.d_date (datekey) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_stnacctinfodtl_supp_key_fkey FOREIGN KEY (supp_key)
        REFERENCES dwh.d_vendor (vendor_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_stnacctinfodtl
    OWNER to proconnect;
-- Index: f_stnacctinfodtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_stnacctinfodtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_stnacctinfodtl_key_idx1
    ON dwh.f_stnacctinfodtl USING btree
    (ou_id COLLATE public.nocase ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST, account_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;