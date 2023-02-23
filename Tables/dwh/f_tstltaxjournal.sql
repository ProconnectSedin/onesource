-- Table: dwh.f_tstltaxjournal

-- DROP TABLE IF EXISTS dwh.f_tstltaxjournal;

CREATE TABLE IF NOT EXISTS dwh.f_tstltaxjournal
(
    tstl_tax_journal_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tstltaxjournal_company_key bigint NOT NULL,
    tstltaxjournal_curr_key bigint NOT NULL,
    company_code character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tax_jv_no character varying(36) COLLATE public.nocase,
    num_type character varying(20) COLLATE public.nocase,
    tax_type character varying(50) COLLATE public.nocase,
    tax_community character varying(50) COLLATE public.nocase,
    tax_region character varying(20) COLLATE public.nocase,
    tran_date timestamp without time zone,
    cur_code character varying(20) COLLATE public.nocase,
    pay_rec_fbid character varying(40) COLLATE public.nocase,
    bank_code character varying(64) COLLATE public.nocase,
    pay_vouc_num_type character varying(20) COLLATE public.nocase,
    decl_year character varying(20) COLLATE public.nocase,
    decl_period character varying(30) COLLATE public.nocase,
    fbid character varying(40) COLLATE public.nocase,
    amount numeric(25,2),
    status character varying(16) COLLATE public.nocase,
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    tran_status character varying(50) COLLATE public.nocase,
    tran_type character varying(50) COLLATE public.nocase,
    payment_no character varying(36) COLLATE public.nocase,
    guid character varying(256) COLLATE public.nocase,
    cgstamount numeric(25,2),
    sgstamount numeric(25,2),
    igstamount numeric(25,2),
    utgst_amount numeric(25,2),
    cess1 numeric(25,2),
    cess2 numeric(25,2),
    cess3 numeric(25,2),
    cess4 numeric(25,2),
    cess5 numeric(25,2),
    cess6 numeric(25,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_tstltaxjournal_pkey PRIMARY KEY (tstl_tax_journal_key),
    CONSTRAINT f_tstltaxjournal_ukey UNIQUE (company_code, tax_jv_no),
    CONSTRAINT f_tstltaxjournal_tstltaxjournal_company_key_fkey FOREIGN KEY (tstltaxjournal_company_key)
        REFERENCES dwh.d_company (company_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_tstltaxjournal_tstltaxjournal_curr_key_fkey FOREIGN KEY (tstltaxjournal_curr_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_tstltaxjournal
    OWNER to proconnect;