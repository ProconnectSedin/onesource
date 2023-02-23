-- Table: stg.stg_crd_pur_addln_dtl

-- DROP TABLE IF EXISTS stg.stg_crd_pur_addln_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_crd_pur_addln_dtl
(
    bu_id character varying(80) COLLATE public.nocase NOT NULL,
    ou_id integer NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    event character varying(160) COLLATE public.nocase NOT NULL,
    finance_book character varying(80) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    usage_id character varying(80) COLLATE public.nocase NOT NULL,
    effective_from_date timestamp without time zone NOT NULL,
    supplier_group character varying(80) COLLATE public.nocase,
    supplier_code character varying(64) COLLATE public.nocase,
    receipt_at character varying(64) COLLATE public.nocase,
    number_series character varying(40) COLLATE public.nocase,
    item_group character varying(40) COLLATE public.nocase,
    item_code character varying(128) COLLATE public.nocase,
    item_variant character varying(32) COLLATE public.nocase,
    folder character varying(160) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    effective_to_date timestamp without time zone,
    ma_createdby character varying(160) COLLATE public.nocase,
    ma_createddate timestamp without time zone,
    ma_modifiedby character varying(160) COLLATE public.nocase,
    ma_modifieddate timestamp without time zone,
    ma_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_crd_pur_addln_dtl
    OWNER to proconnect;