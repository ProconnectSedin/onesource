-- Table: raw.raw_crd_pur_defn

-- DROP TABLE IF EXISTS "raw".raw_crd_pur_defn;

CREATE TABLE IF NOT EXISTS "raw".raw_crd_pur_defn
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    bu_id character varying(80) COLLATE public.nocase NOT NULL,
    ou_id integer NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    finance_book character varying(80) COLLATE public.nocase NOT NULL,
    account_code character varying(128) COLLATE public.nocase NOT NULL,
    event character varying(160) COLLATE public.nocase NOT NULL,
    effective_from_date timestamp without time zone,
    cost_center character varying(40) COLLATE public.nocase,
    effective_to_date timestamp without time zone,
    addln_para_yn character varying(48) COLLATE public.nocase,
    ma_createdby character varying(160) COLLATE public.nocase,
    ma_createddate timestamp without time zone,
    ma_modifiedby character varying(160) COLLATE public.nocase,
    ma_modifieddate timestamp without time zone,
    ma_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_crd_pur_defn_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_crd_pur_defn
    OWNER to proconnect;