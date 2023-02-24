-- Table: dwh.f_sadcustdrdocadjdtl

-- DROP TABLE IF EXISTS dwh.f_sadcustdrdocadjdtl;

CREATE TABLE IF NOT EXISTS dwh.f_sadcustdrdocadjdtl
(
    sadcustdrdocadjdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    customer_key bigint NOT NULL,
    ou_id integer,
    adjustment_no character varying(40) COLLATE public.nocase,
    dr_doc_ou integer,
    dr_doc_type character varying(80) COLLATE public.nocase,
    dr_doc_no character varying(40) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    au_due_date timestamp without time zone,
    au_dr_doc_unadj_amt numeric(13,2),
    au_cust_code character varying(40) COLLATE public.nocase,
    au_dr_doc_cur character varying(10) COLLATE public.nocase,
    au_crosscur_erate numeric(13,2),
    discount numeric(13,2),
    charges numeric(13,2),
    writeoff_amount numeric(13,2),
    dr_doc_adj_amt numeric(13,2),
    proposed_discount numeric(13,2),
    proposed_charges numeric(13,2),
    au_discount_date timestamp without time zone,
    au_billing_point integer,
    au_dr_doc_date timestamp without time zone,
    au_fb_id character varying(40) COLLATE public.nocase,
    guid character varying(260) COLLATE public.nocase,
    au_base_exrate numeric(13,2),
    au_par_base_exrate numeric(13,2),
    au_disc_available numeric(13,2),
    adjustment_amt numeric(13,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_sadcustdrdocadjdtl_pkey PRIMARY KEY (sadcustdrdocadjdtl_key),
    CONSTRAINT f_sadcustdrdocadjdtl_ukey UNIQUE (ou_id, adjustment_no, dr_doc_ou, dr_doc_type, dr_doc_no, term_no),
    CONSTRAINT f_sadcustdrdocadjdtl_customer_key_fkey FOREIGN KEY (customer_key)
        REFERENCES dwh.d_customer (customer_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_sadcustdrdocadjdtl
    OWNER to proconnect;
-- Index: f_sadcustdrdocadjdtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_sadcustdrdocadjdtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_sadcustdrdocadjdtl_key_idx1
    ON dwh.f_sadcustdrdocadjdtl USING btree
    (ou_id ASC NULLS LAST, adjustment_no COLLATE public.nocase ASC NULLS LAST, dr_doc_ou ASC NULLS LAST, dr_doc_type COLLATE public.nocase ASC NULLS LAST, dr_doc_no COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;