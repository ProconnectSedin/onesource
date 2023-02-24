-- Table: dwh.f_cbadjacctinfodtl

-- DROP TABLE IF EXISTS dwh.f_cbadjacctinfodtl;

CREATE TABLE IF NOT EXISTS dwh.f_cbadjacctinfodtl
(
    cbadjacctinfodtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_key bigint,
    account_key bigint,
    currency_key bigint,
    cust_key bigint,
    ou_id integer,
    tran_no character varying(40) COLLATE public.nocase,
    tran_type character varying(80) COLLATE public.nocase,
    account_code character varying(80) COLLATE public.nocase,
    drcr_flag character varying(20) COLLATE public.nocase,
    line_no integer,
    company_code character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    fin_post_date timestamp without time zone,
    currency_code character varying(10) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    tran_amount numeric(25,2),
    basecur_erate numeric(25,2),
    base_amount numeric(25,2),
    pbcur_erate numeric(25,2),
    par_base_amt numeric(25,2),
    fin_post_status character varying(50) COLLATE public.nocase,
    transaction_date timestamp without time zone,
    account_type character varying(30) COLLATE public.nocase,
    guid character varying(260) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    ref_doc_no character varying(40) COLLATE public.nocase,
    ref_doc_ou integer,
    ref_doc_type character varying(80) COLLATE public.nocase,
    ref_doc_term character varying(40) COLLATE public.nocase,
    cust_code character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time  zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_cbadjacctinfodtl_pkey PRIMARY KEY (cbadjacctinfodtl_key),
    CONSTRAINT f_cbadjacctinfodtl_ukey UNIQUE (ou_id, tran_no, tran_type, account_code, drcr_flag, line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cbadjacctinfodtl
    OWNER to proconnect;
-- Index: f_cbadjacctinfodtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_cbadjacctinfodtl_key_idx;

CREATE INDEX IF NOT EXISTS f_cbadjacctinfodtl_key_idx
    ON dwh.f_cbadjacctinfodtl USING btree
    (ou_id ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, account_code COLLATE public.nocase ASC NULLS LAST, drcr_flag COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS f_cbadjacctinfodtl_key_idx1
    ON dwh.f_cbadjacctinfodtl USING btree
	(	cust_code, ou_id);

CREATE INDEX IF NOT EXISTS f_cbadjacctinfodtl_key_idx2
    ON dwh.f_cbadjacctinfodtl USING btree
	(currency_code);

CREATE INDEX IF NOT EXISTS f_cbadjacctinfodtl_key_idx3
    ON dwh.f_cbadjacctinfodtl USING btree
	(account_code);

CREATE INDEX IF NOT EXISTS f_cbadjacctinfodtl_key_idx4
    ON dwh.f_cbadjacctinfodtl USING btree
	(company_code);
	
