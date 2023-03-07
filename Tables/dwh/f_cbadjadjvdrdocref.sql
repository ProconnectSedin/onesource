-- Table: dwh.f_cbadjadjvdrdocref

-- DROP TABLE IF EXISTS dwh.f_cbadjadjvdrdocref;

CREATE TABLE IF NOT EXISTS dwh.f_cbadjadjvdrdocref
(
    cbadjadjvdrdocref_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    adj_vdr_doc_dtl_key bigint,
    parent_key character varying(260) COLLATE public.nocase,
    ref_dr_doc_no character varying(40) COLLATE public.nocase,
    dr_doc_ou integer,
    dr_doc_type character varying(80) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    sale_ord_ref character varying(40) COLLATE public.nocase,
    dr_doc_adj_amt numeric(20,2),
    au_dr_doc_unadj_amt numeric(20,2),
    tran_type character varying(80) COLLATE public.nocase,
    au_dr_disc numeric(20,2),
    au_dr_charge numeric(20,2),
    guid character varying(260) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_cbadjadjvdrdocref_pkey PRIMARY KEY (cbadjadjvdrdocref_key),
    CONSTRAINT f_cbadjadjvdrdocref_ukey UNIQUE (parent_key, ref_dr_doc_no, dr_doc_ou, dr_doc_type, term_no, guid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cbadjadjvdrdocref
    OWNER to proconnect;
-- Index: f_cbadjadjvdrdocref_key_idx

-- DROP INDEX IF EXISTS dwh.f_cbadjadjvdrdocref_key_idx;

CREATE INDEX IF NOT EXISTS f_cbadjadjvdrdocref_key_idx
    ON dwh.f_cbadjadjvdrdocref USING btree
    (parent_key COLLATE public.nocase ASC NULLS LAST, ref_dr_doc_no COLLATE public.nocase ASC NULLS LAST, dr_doc_ou ASC NULLS LAST, dr_doc_type COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST, guid COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;