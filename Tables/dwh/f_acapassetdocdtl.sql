-- Table: dwh.f_acapassetdocdtl

-- DROP TABLE IF EXISTS dwh.f_acapassetdocdtl;

CREATE TABLE IF NOT EXISTS dwh.f_acapassetdocdtl
(
    acapassetdocdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    currency_key bigint NOT NULL,
    cap_number character varying(40) COLLATE public.nocase,
    asset_number character varying(40) COLLATE public.nocase,
    doc_type character varying(80) COLLATE public.nocase,
    doc_number character varying(40) COLLATE public.nocase,
    supplier_name character varying(120) COLLATE public.nocase,
    doc_date timestamp without time zone,
    doc_amount numeric(13,2),
    pending_cap_amt numeric(13,2),
    proposal_number character varying(40) COLLATE public.nocase,
    currency character varying(10) COLLATE public.nocase,
    exchange_rate numeric(13,2),
    cap_amount numeric(13,2),
    finance_bookid character varying(40) COLLATE public.nocase,
    doc_status character varying(50) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tran_ou integer,
    tran_type character varying(20) COLLATE public.nocase,
    cap_flag character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_acapassetdocdtl_pkey PRIMARY KEY (acapassetdocdtl_key),
    CONSTRAINT f_acapassetdocdtl_ukey UNIQUE (ou_id, cap_number, asset_number, doc_type, doc_number),
    CONSTRAINT f_acapassetdocdtl_currency_key_fkey FOREIGN KEY (currency_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_acapassetdocdtl
    OWNER to proconnect;
-- Index: f_acapassetdocdtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_acapassetdocdtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_acapassetdocdtl_key_idx1
    ON dwh.f_acapassetdocdtl USING btree
    (ou_id ASC NULLS LAST, cap_number COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, doc_type COLLATE public.nocase ASC NULLS LAST, doc_number COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;