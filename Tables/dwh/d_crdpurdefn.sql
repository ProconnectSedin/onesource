-- Table: dwh.d_crdpurdefn

-- DROP TABLE IF EXISTS dwh.d_crdpurdefn;

CREATE TABLE IF NOT EXISTS dwh.d_crdpurdefn
(
    crdpurdefn_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    bu_id character varying(40) COLLATE public.nocase,
    ou_id integer,
    company_code character varying(20) COLLATE public.nocase,
    finance_book character varying(40) COLLATE public.nocase,
    account_code character varying(64) COLLATE public.nocase,
    event character varying(80) COLLATE public.nocase,
    effective_from_date timestamp without time zone,
    cost_center character varying(20) COLLATE public.nocase,
    effective_to_date timestamp without time zone,
    addln_para_yn character varying(24) COLLATE public.nocase,
    ma_createdby character varying(80) COLLATE public.nocase,
    ma_createddate timestamp without time zone,
    ma_modifiedby character varying(80) COLLATE public.nocase,
    ma_modifieddate timestamp without time zone,
    ma_timestamp integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_crdpurdefn_pkey PRIMARY KEY (crdpurdefn_key),
    CONSTRAINT d_crdpurdefn_ukey UNIQUE (bu_id, ou_id, company_code, finance_book, account_code, addln_para_yn)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_crdpurdefn
    OWNER to proconnect;