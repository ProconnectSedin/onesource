-- Table: dwh.d_ardsupplieraccountmst

-- DROP TABLE IF EXISTS dwh.d_ardsupplieraccountmst;

CREATE TABLE IF NOT EXISTS dwh.d_ardsupplieraccountmst
(
    ard_supp_acc_mst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(20) COLLATE public.nocase,
    supplier_group character varying(40) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    effective_from timestamp without time zone,
    sequence_no integer,
    "timestamp" integer,
    supppay_account character varying(64) COLLATE public.nocase,
    suppprepay_account character varying(64) COLLATE public.nocase,
    suppdeposit_account character varying(64) COLLATE public.nocase,
    resou_id integer,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_ardsupplieraccountmst_pkey PRIMARY KEY (ard_supp_acc_mst_key),
    CONSTRAINT d_ardsupplieraccountmst_ukey UNIQUE (company_code, supplier_group, fb_id, currency_code, effective_from, sequence_no, supppay_account)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_ardsupplieraccountmst
    OWNER to proconnect;