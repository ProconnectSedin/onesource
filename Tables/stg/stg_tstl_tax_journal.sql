-- Table: stg.stg_tstl_tax_journal

-- DROP TABLE IF EXISTS stg.stg_tstl_tax_journal;

CREATE TABLE IF NOT EXISTS stg.stg_tstl_tax_journal
(
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    tran_ou integer NOT NULL,
    tax_jv_no character varying(72) COLLATE public.nocase NOT NULL,
    num_type character varying(40) COLLATE public.nocase NOT NULL,
    tax_type character varying(100) COLLATE public.nocase NOT NULL,
    tax_community character varying(100) COLLATE public.nocase NOT NULL,
    tax_region character varying(40) COLLATE public.nocase,
    tran_date timestamp without time zone NOT NULL,
    cur_code character(20) COLLATE public.nocase NOT NULL,
    comment character varying(1024) COLLATE public.nocase,
    pay_recp_flag character varying(100) COLLATE public.nocase,
    pay_recp_voucher_no character varying(72) COLLATE public.nocase,
    pay_rec_fbid character varying(80) COLLATE public.nocase,
    bank_code character varying(128) COLLATE public.nocase,
    pay_vouc_num_type character varying(40) COLLATE public.nocase,
    decl_year character varying(40) COLLATE public.nocase NOT NULL,
    decl_period character varying(60) COLLATE public.nocase NOT NULL,
    fbid character varying(80) COLLATE public.nocase NOT NULL,
    amount numeric NOT NULL,
    status character varying(32) COLLATE public.nocase NOT NULL,
    rev_vouch_no character varying(72) COLLATE public.nocase,
    rev_date timestamp without time zone,
    created_by character varying(120) COLLATE public.nocase NOT NULL,
    created_date timestamp without time zone NOT NULL,
    modified_by character varying(120) COLLATE public.nocase NOT NULL,
    modified_date timestamp without time zone NOT NULL,
    tran_status character varying(100) COLLATE public.nocase,
    tran_type character varying(100) COLLATE public.nocase,
    pay_recp_ou integer,
    pay_recp_trantype character varying(100) COLLATE public.nocase,
    payment_no character varying(72) COLLATE public.nocase,
    guid character varying(512) COLLATE public.nocase,
    cgstamount numeric,
    sgstamount numeric,
    igstamount numeric,
    utgst_amount numeric,
    cess1 numeric,
    cess2 numeric,
    cess3 numeric,
    cess4 numeric,
    cess5 numeric,
    cess6 numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT tstl_tax_journal_pkey PRIMARY KEY (company_code, tax_jv_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_tstl_tax_journal
    OWNER to proconnect;
-- Index: stg_tstl_tax_journal_idx

-- DROP INDEX IF EXISTS stg.stg_tstl_tax_journal_idx;

CREATE INDEX IF NOT EXISTS stg_tstl_tax_journal_idx
    ON stg.stg_tstl_tax_journal USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, tax_jv_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;