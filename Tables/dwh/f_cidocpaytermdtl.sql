-- Table: dwh.f_cidocpaytermdtl

-- DROP TABLE IF EXISTS dwh.f_cidocpaytermdtl;

CREATE TABLE IF NOT EXISTS dwh.f_cidocpaytermdtl
(
    ci_doc_payterm_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    cidocpaytermdtl_company_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(36) COLLATE public.nocase,
    pay_term character varying(30) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    lo_id character varying(40) COLLATE public.nocase,
    batch_id character varying(256) COLLATE public.nocase,
    component_id character varying(32) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    due_date timestamp without time zone,
    due_amount_type character varying(2) COLLATE public.nocase,
    due_percent numeric(25,2),
    due_amount numeric(25,2),
    disc_comp_amount numeric(25,2),
    disc_amount_type character varying(2) COLLATE public.nocase,
    disc_date timestamp without time zone,
    disc_percent numeric(25,2),
    disc_amount numeric(25,2),
    penalty_percent numeric(25,2),
    esr_ref_no character varying(60) COLLATE public.nocase,
    base_due_amount numeric(25,2),
    base_disc_amount numeric(25,2),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    rev_flag character varying(16) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_cidocpaytermdtl_pkey PRIMARY KEY (ci_doc_payterm_dtl_key),
    CONSTRAINT f_cidocpaytermdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, pay_term, term_no),
    CONSTRAINT f_cidocpaytermdtl_cidocpaytermdtl_company_key_fkey FOREIGN KEY (cidocpaytermdtl_company_key)
        REFERENCES dwh.d_company (company_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cidocpaytermdtl
    OWNER to proconnect;