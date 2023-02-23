-- Table: dwh.d_crdpuraddlndtl

-- DROP TABLE IF EXISTS dwh.d_crdpuraddlndtl;

CREATE TABLE IF NOT EXISTS dwh.d_crdpuraddlndtl
(
    crdpuraddlndtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    bu_id character varying(40) COLLATE public.nocase,
    ou_id integer,
    company_code character varying(20) COLLATE public.nocase,
    event character varying(80) COLLATE public.nocase,
    finance_book character varying(40) COLLATE public.nocase,
    account_code character varying(64) COLLATE public.nocase,
    usage_id character varying(40) COLLATE public.nocase,
    effective_from_date timestamp without time zone,
    supplier_group character varying(40) COLLATE public.nocase,
    supplier_code character varying(32) COLLATE public.nocase,
    receipt_at character varying(32) COLLATE public.nocase,
    number_series character varying(20) COLLATE public.nocase,
    item_group character varying(20) COLLATE public.nocase,
    item_code character varying(64) COLLATE public.nocase,
    item_variant character varying(16) COLLATE public.nocase,
    folder character varying(80) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    ma_createdby character varying(80) COLLATE public.nocase,
    ma_createddate timestamp without time zone,
    ma_timestamp integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_crdpuraddlndtl_pkey PRIMARY KEY (crdpuraddlndtl_key),
    CONSTRAINT d_crdpuraddlndtl_ukey UNIQUE (bu_id, ou_id, company_code, account_code, usage_id, cost_center, item_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_crdpuraddlndtl
    OWNER to proconnect;